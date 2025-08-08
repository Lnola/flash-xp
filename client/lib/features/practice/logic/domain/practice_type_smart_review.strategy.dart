import 'package:flashxp/features/practice/data/dto/question.dto.dart';
import 'package:flashxp/features/practice/data/quick_practice.repository.dart';
import 'package:flashxp/features/practice/logic/domain/practice_type.strategy.dart';
import 'package:flashxp/shared/helpers/result.dart';

class SmartReviewStrategy implements PracticeTypeStrategy {
  // TODO: Update the logic to work with SmartReviewRepository once that is implemented
  final _quickPracticeRepository = QuickPracticeRepository();
  @override
  Future<Result<List<QuestionDto>>> getQuestions(int deckId) {
    return _quickPracticeRepository.getQuestions(deckId);
  }
}
