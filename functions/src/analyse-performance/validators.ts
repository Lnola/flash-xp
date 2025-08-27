import { HttpError } from '../helpers/http';
import { AccuracyRate, QuestionTypeOccurrenceCount } from './types';

export function verifyAccuracyRate(
  accuracyRate: object,
): asserts accuracyRate is AccuracyRate {
  if (
    !(accuracyRate as AccuracyRate).correct ||
    !(accuracyRate as AccuracyRate).total ||
    !(accuracyRate as AccuracyRate).value
  ) {
    throw new HttpError(400, `Invalid accuracy rate: ${accuracyRate}`);
  }
}

export function verifyQuestionTypeOccurrenceCount(
  questionTypeOccurrenceCount: object,
): asserts questionTypeOccurrenceCount is QuestionTypeOccurrenceCount {
  if (
    !(questionTypeOccurrenceCount as QuestionTypeOccurrenceCount)
      .multipleChoiceCount ||
    !(questionTypeOccurrenceCount as QuestionTypeOccurrenceCount)
      .selfAssessmentCount
  ) {
    throw new HttpError(
      400,
      `Invalid question type occurrence count: ${questionTypeOccurrenceCount}`,
    );
  }
}
