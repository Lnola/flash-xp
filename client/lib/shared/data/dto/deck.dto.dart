import 'package:flashxp/shared/logic/domain/practice_mode.enum.dart';

class DeckDto {
  final int id;
  final String title;
  final int totalQuestions;
  final int progress;
  final PracticeMode mode;

  DeckDto({
    required this.id,
    required this.title,
    required this.totalQuestions,
    required this.progress,
    required this.mode,
  });
}
