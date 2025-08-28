import { logger } from 'firebase-functions';
import { config } from './constants';
import { chunkText } from '../helpers/text';
import { Flashcard, MultipleChoice, QuestionType } from './question-type';
import { Ai } from '../helpers/ai';

export class QuestionGenerator {
  private ai = new Ai();
  private config = config;
  private questionType: QuestionType;

  constructor(questionType: QuestionType) {
    this.questionType = questionType;
  }

  async summarizeText(text: string): Promise<string> {
    const chunks = chunkText(text, this.config.chunkSize);
    logger.info(
      `Generating summary for ${chunks.length} chunk(s).
      Model: ${this.config.summaryModel}`,
    );

    const summaryPromises = chunks.map((chunk, index) => {
      logger.info(`Processing chunk: ${index + 1}/${chunks.length}`);
      return this.ai.call({
        model: this.config.summaryModel,
        messages: [
          { role: 'system', content: this.config.summaryPrompt },
          { role: 'user', content: chunk },
        ],
      });
    });
    const summaries = await Promise.all(summaryPromises);
    return summaries.join('\n\n');
  }

  async generate(text: string): Promise<Flashcard[] | MultipleChoice[]> {
    logger.info(
      `Generating questions.
      Model: ${this.config.questionModel}`,
    );

    const questionsString = await this.ai.call({
      model: this.config.questionModel,
      messages: [
        { role: 'system', content: this.questionType.prompt },
        { role: 'user', content: text },
      ],
    });
    return JSON.parse(questionsString);
  }
}
