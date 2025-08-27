import { logger } from 'firebase-functions';
import { Ai } from '../helpers/ai';
import { AccuracyRate, QuestionTypeOccurrenceCount } from './types';
import { config } from './config';

export class PerformanceAnalyser {
  private ai = new Ai();
  private config = config;
  private accuracyRate: AccuracyRate;
  private multipleChoiceAccuracyRate: AccuracyRate;
  private selfAssessmentAccuracyRate: AccuracyRate;
  private questionTypeOccurrenceCount: QuestionTypeOccurrenceCount;

  constructor(params: PerformanceAnalyserParams) {
    this.accuracyRate = params.accuracyRate;
    this.multipleChoiceAccuracyRate = params.multipleChoiceAccuracyRate;
    this.selfAssessmentAccuracyRate = params.selfAssessmentAccuracyRate;
    this.questionTypeOccurrenceCount = params.questionTypeOccurrenceCount;
  }

  async analyse(): Promise<string> {
    logger.info(
      `Generating performance analysis.
      Model: ${this.config.performanceAnalysisModel}`,
    );

    const payload = {
      accuracyRate: this.accuracyRate,
      multipleChoiceAccuracyRate: this.multipleChoiceAccuracyRate,
      selfAssessmentAccuracyRate: this.selfAssessmentAccuracyRate,
      questionTypeOccurrenceCount: this.questionTypeOccurrenceCount,
    };
    const analysis = await this.ai.call({
      model: this.config.performanceAnalysisModel,
      messages: [
        { role: 'system', content: this.config.performanceAnalysisPrompt },
        { role: 'user', content: JSON.stringify(payload) },
      ],
    });
    return analysis;
  }
}

type PerformanceAnalyserParams = {
  accuracyRate: AccuracyRate;
  multipleChoiceAccuracyRate: AccuracyRate;
  selfAssessmentAccuracyRate: AccuracyRate;
  questionTypeOccurrenceCount: QuestionTypeOccurrenceCount;
};
