import 'dotenv/config';
import OpenAI from 'openai';
import { logger } from 'firebase-functions';
import { HttpError } from './helpers/http';

type Flashcard = {
  question: string;
  answer: string;
};

export class QuestionGenerator {
  private ai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });
  private static CHUNK_SIZE = parseInt(process.env.CHUNK_SIZE || '6000', 10);
  private static SUMMARY_MODEL = process.env.SUMMARY_MODEL || 'gpt-3.5-turbo';
  private static QUESTION_MODEL = process.env.QUESTION_MODEL || 'gpt-4-turbo';

  private _chunkText(text: string, chunkSize: number): string[] {
    const chunks = [];
    for (let i = 0; i < text.length; i += chunkSize) {
      chunks.push(text.slice(i, i + chunkSize));
    }
    return chunks;
  }

  private async _getAiSummary(chunk: string, model: string): Promise<string> {
    const response = await this.ai.chat.completions.create({
      model,
      messages: [
        {
          role: 'system',
          content: `Summarize the following text into concise bullet points.`,
        },
        {
          role: 'user',
          content: chunk,
        },
      ],
    });
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
    const chunks = this._chunkText(text, QuestionGenerator.CHUNK_SIZE);
    logger.info(
      `Generating summary for ${chunks.length} chunk(s).
      Model: ${QuestionGenerator.SUMMARY_MODEL}`,
    );

    const summaryPromises = chunks.map((chunk, index) => {
      logger.info(`Processing chunk: ${index + 1}/${chunks.length}`);
      return this._getAiSummary(chunk, QuestionGenerator.SUMMARY_MODEL);
    });
    const summaries = await Promise.all(summaryPromises);
    return summaries.join('\n\n');
  }

  async generate(text: string): Promise<Flashcard[]> {
    logger.info(
      `Generating questions.
      Model: ${QuestionGenerator.QUESTION_MODEL}`,
    );
    const prompt = `
Create a list of flashcards from the following text.
Respond ONLY with valid JSON in the format:
[
  { "question": "...", "answer": "..." },
  ...
]`;

    const response = await this.ai.chat.completions.create({
      model: QuestionGenerator.QUESTION_MODEL,
      messages: [
        { role: 'system', content: prompt },
        { role: 'user', content: text },
      ],
    });
    if (
      !response.choices ||
      response.choices.length === 0 ||
      !response.choices[0].message.content
    ) {
      throw new HttpError(403, 'No response from GPT');
    }
    return JSON.parse(response.choices[0].message.content);
  }
}
