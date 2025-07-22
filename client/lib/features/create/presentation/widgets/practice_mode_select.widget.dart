import 'package:flashxp/shared/logic/domain/practice_mode.enum.dart';
import 'package:flashxp/shared/logic/domain/practice_mode_api_label.extension.dart';
import 'package:flashxp/shared/presentation/widgets/input/flash_dropdown.dart';
import 'package:flutter/material.dart';

class PracticeModeSelectWidget extends StatelessWidget {
  final PracticeMode mode;
  final ValueChanged<PracticeMode> updateMode;

  const PracticeModeSelectWidget({
    super.key,
    required this.mode,
    required this.updateMode,
  });

  @override
  Widget build(BuildContext context) {
    return FlashDropdown<PracticeMode>(
      value: mode,
      values: PracticeMode.values,
      labelBuilder: (mode) => mode.label,
      onChanged: (mode) => updateMode(mode!),
    );
  }
}
