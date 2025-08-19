import 'dotenv/config';
import OpenAI from 'openai';
import { logger } from 'firebase-functions';
import { HttpError } from '../helpers/http';

export class QuestionGenerator {
  private ai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });
  private static CHUNK_SIZE = parseInt(process.env.CHUNK_SIZE || '6000', 10);
  private static SUMMARY_MODEL = process.env.SUMMARY_MODEL || 'gpt-3.5-turbo';
  private static QUESTION_MODEL = process.env.QUESTION_MODEL || 'gpt-4-turbo';

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

  private _chunkText(text: string, chunkSize: number): string[] {
    const chunks = [];
    for (let i = 0; i < text.length; i += chunkSize) {
      chunks.push(text.slice(i, i + chunkSize));
    }
    return chunks;
  }

  async summarizeText(text: string): Promise<string> {
    const chunks = this._chunkText(text, QuestionGenerator.CHUNK_SIZE);
    logger.info(
      `Generating summary for ${chunks.length} chunk(s).
      Model: ${QuestionGenerator.SUMMARY_MODEL}`,
    );

    const summaryPromises = chunks.map((chunk, index) => {
      logger.info(`Processing chunk: ${index + 1}/${chunks.length}`);
      return this._callAi({
        model: QuestionGenerator.SUMMARY_MODEL,
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
      Model: ${QuestionGenerator.QUESTION_MODEL}`,
    );

    const questionsString = await this._callAi({
      model: QuestionGenerator.QUESTION_MODEL,
      messages: [
        { role: 'system', content: FLASHCARD_PROMPT },
        { role: 'user', content: text },
      ],
    });
    return JSON.parse(questionsString);
  }
}

const SUMMARY_PROMPT = `Summarize the following text into concise bullet points.`;

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
