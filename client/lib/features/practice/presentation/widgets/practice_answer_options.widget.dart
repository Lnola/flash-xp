import 'package:flashxp/features/practice/logic/models/answer_option_button.model.dart';
import 'package:flashxp/features/practice/presentation/widgets/practice_answer_option_button.widget.dart';
import 'package:flutter/material.dart';

class PracticeAnswerOptions extends StatelessWidget {
  final List<AnswerOptionButtonModel> answerOptionButtons;

  const PracticeAnswerOptions({
    super.key,
    required this.answerOptionButtons,
  });

  void noop() {}

  @override
  Widget build(BuildContext context) {
    final spacing = 8.0;

    return LayoutBuilder(
      builder: (context, constraints) => Center(
        child: Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: answerOptionButtons
              .map(
                (option) => SizedBox(
                  width: (constraints.maxWidth - spacing) / 2,
                  child: PracticeAnswerOptionButton(
                    label: option.label,
                    onPressed: !option.isDisabled ? option.onPressed : noop,
                    state: option.state,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
