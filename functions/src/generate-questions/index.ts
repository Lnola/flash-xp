import { logger } from 'firebase-functions';
import { config, SUMMARY_PROMPT } from './constants';
import { chunkText } from '../helpers/text';
import { Flashcard, MultipleChoice, QuestionType } from './question-type';
import { Ai } from '../helpers/ai';

// TODO: Do a bit of a cleanup
export class QuestionGenerator {
  private ai = new Ai();
  private config = config;
  private questionType: QuestionType;

  constructor(questionType: QuestionType) {
    this.questionType = questionType;
  }

  async summarizeText(text: string): Promise<string> {
    const chunks = chunkText(text, this.config.CHUNK_SIZE);
    logger.info(
      `Generating summary for ${chunks.length} chunk(s).
      Model: ${this.config.SUMMARY_MODEL}`,
    );

    const summaryPromises = chunks.map((chunk, index) => {
      logger.info(`Processing chunk: ${index + 1}/${chunks.length}`);
      return this.ai.call({
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

  async generate(text: string): Promise<Flashcard[] | MultipleChoice[]> {
    logger.info(
      `Generating questions.
      Model: ${this.config.QUESTION_MODEL}`,
    );

    const questionsString = await this.ai.call({
      model: this.config.QUESTION_MODEL,
      messages: [
        { role: 'system', content: this.questionType.prompt },
        { role: 'user', content: text },
      ],
    });
    return JSON.parse(questionsString);
  }
}
