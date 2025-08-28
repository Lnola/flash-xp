import { HttpError } from '../helpers/http';
import { QuestionType, QuestionTypeKey } from './question-type';

export function verifyQuestionType(
  type: string,
): asserts type is QuestionTypeKey {
  if (!(type in QuestionType)) {
    throw new HttpError(400, `Invalid question type: ${type}`);
  }
}
