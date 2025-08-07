import 'package:flashxp/shared/logic/domain/practice_mode.enum.dart';
import 'package:flashxp/shared/logic/domain/practice_mode_api_label.extension.dart';

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

  static DeckDto fromJson(json) {
    return DeckDto(
      id: json['id'],
      title: json['title'],
      totalQuestions: json['questionCount'],
      progress: json['progress'] ?? 0,
      mode: PracticeModeApiLabel.getByLabel(json['questionType']),
    );
  }
}
