import 'package:flashxp/features/practice/data/dto/question.dto.dart';
import 'package:flashxp/features/practice/data/smart_review.repository.dart';
import 'package:flashxp/features/practice/logic/domain/practice_type.strategy.dart';
import 'package:flashxp/shared/helpers/result.dart';

class SmartReviewStrategy implements PracticeTypeStrategy {
  final _smartReviewRepository = SmartReviewRepository();

  @override
  Future<Result<List<QuestionDto>>> getQuestions(int deckId) {
    return _smartReviewRepository.getQuestions(deckId);
  }

  @override
  Future<void> handleCorrectAnswer(int questionId) {
    return _smartReviewRepository.incrementBox(questionId);
  }
}
