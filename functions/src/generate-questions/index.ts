import 'dotenv/config';
import OpenAI from 'openai';
import { logger } from 'firebase-functions';
import { HttpError } from '../helpers/http';
import { config, SUMMARY_PROMPT } from './constants';
import { chunkText } from '../helpers/text';

export class QuestionGenerator {
  private ai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });
  private config = config;

  private async _callAi({ model, messages }: CallAiOptions): Promise<string> {
    const response = await this.ai.chat.completions.create({ model, messages });
    if (
      !response.choices ||
      response.choices.length === 0 ||
      !response.choices[0].message.content
    ) {
      throw new HttpError(403, 'No response from GPT');
    }
    return response.choices[0].message.content;
  }

  async summarizeText(text: string): Promise<string> {
    const chunks = chunkText(text, this.config.CHUNK_SIZE);
    logger.info(
      `Generating summary for ${chunks.length} chunk(s).
      Model: ${this.config.SUMMARY_MODEL}`,
    );

    const summaryPromises = chunks.map((chunk, index) => {
      logger.info(`Processing chunk: ${index + 1}/${chunks.length}`);
      return this._callAi({
        model: this.config.SUMMARY_MODEL,
        messages: [
          { role: 'system', content: SUMMARY_PROMPT },
          { role: 'user', content: chunk },
        ],
      });
    });
    const summaries = await Promise.all(summaryPromises);
    return summaries.join('\n\n');
  }

  async generate(text: string): Promise<Flashcard[]> {
    logger.info(
      `Generating questions.
      Model: ${this.config.QUESTION_MODEL}`,
    );

    const questionsString = await this._callAi({
      model: this.config.QUESTION_MODEL,
      messages: [
        { role: 'system', content: FLASHCARD_PROMPT },
        { role: 'user', content: text },
      ],
    });
    return JSON.parse(questionsString);
  }
}

type Flashcard = {
  question: string;
  answer: string;
};
const FLASHCARD_PROMPT = `Create a list of flashcards from the following text. 
Respond ONLY with valid JSON in the format:
[
  { "question": "...", "answer": "..." },
  ...
]`;

type CallAiOptions =
  OpenAI.Chat.Completions.ChatCompletionCreateParamsNonStreaming;
