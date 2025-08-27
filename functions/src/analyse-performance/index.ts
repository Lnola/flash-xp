// import { Ai } from '../helpers/ai';

import { AccuracyRate, QuestionTypeOccurrenceCount } from './types';
import { config } from './config';

export class PerformanceAnalyser {
  // private ai = new Ai();
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

  analyse(): string {
    return '';
  }
}

type PerformanceAnalyserParams = {
  accuracyRate: AccuracyRate;
  multipleChoiceAccuracyRate: AccuracyRate;
  selfAssessmentAccuracyRate: AccuracyRate;
  questionTypeOccurrenceCount: QuestionTypeOccurrenceCount;
};
