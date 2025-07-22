import 'package:flashxp/shared/logic/domain/practice_mode.enum.dart';

extension PracticeModeApiLabel on PracticeMode {
  String get label => switch (this) {
        PracticeMode.multipleChoice => 'Multiple Choice',
        PracticeMode.selfAssessment => 'Self Assessment',
      };
}
