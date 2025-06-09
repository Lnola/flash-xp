import 'package:flashxp/shared/data/dto/deck.dto.dart';
import 'package:flashxp/shared/logic/domain/practice_mode.enum.dart';

class DeckRepository {
  Future<List<DeckDto>> fetch() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockDecks();
  }

  List<DeckDto> _mockDecks() {
    return [
      DeckDto(
        id: 1,
        title: 'Long title lorem ipsum dolor sit amet',
        totalQuestions: 4,
        progress: 25,
        mode: PracticeMode.multipleChoice,
      ),
      DeckDto(
        id: 2,
        title: 'Short title',
        totalQuestions: 12,
        progress: 10,
        mode: PracticeMode.multipleChoice,
      ),
      DeckDto(
        id: 3,
        title: 'Short title',
        totalQuestions: 40,
        progress: 40,
        mode: PracticeMode.selfAssessment,
      ),
      DeckDto(
        id: 4,
        title: 'Long title lorem ipsum dolor sit amet',
        totalQuestions: 100,
        progress: 100,
        mode: PracticeMode.selfAssessment,
      ),
    ];
  }
}
