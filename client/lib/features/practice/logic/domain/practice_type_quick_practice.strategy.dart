import 'package:flashxp/features/practice/data/dto/question.dto.dart';
import 'package:flashxp/features/practice/data/quick_practice.repository.dart';
import 'package:flashxp/features/practice/logic/domain/practice_type.strategy.dart';
import 'package:flashxp/shared/helpers/result.dart';

class QuickPracticeStrategy implements PracticeTypeStrategy {
  final _quickPracticeRepository = QuickPracticeRepository();

  @override
  Future<Result<List<QuestionDto>>> getQuestions(int deckId) {
    return _quickPracticeRepository.getQuestions(deckId);
  }

  @override
  Future<void> handleCorrectAnswer(int questionId) {
    return Future.value();
  }
}
