import 'package:flashxp/shared/logic/domain/practice_mode.enum.dart';

// TODO: Update this DTO to match all different uses of it in the app
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

// TODO: create a correct implementation of fromJson without the data mocking
  static DeckDto fromJson(json) {
    return DeckDto(
      id: json['id'],
      title: json['title'],
      totalQuestions: 5,
      progress: 50,
      mode: PracticeMode.multipleChoice,
    );
  }
}
