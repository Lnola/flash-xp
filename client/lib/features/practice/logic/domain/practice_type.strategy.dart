import 'package:flashxp/features/practice/data/dto/question.dto.dart';
import 'package:flashxp/shared/helpers/result.dart';

abstract class PracticeTypeStrategy {
  Future<Result<List<QuestionDto>>> getQuestions(int deckId);
  Future<void> handleCorrectAnswer(int questionId);
}
