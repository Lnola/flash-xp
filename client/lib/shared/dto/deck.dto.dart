import 'package:flashxp/shared/widgets/common/flash_card.dart';

class DeckDto {
  final String id;
  final String title;
  final int totalQuestions;
  final int progress;
  final FlashCardMode mode;

  DeckDto({
    required this.id,
    required this.title,
    required this.totalQuestions,
    required this.progress,
    required this.mode,
  });
}
