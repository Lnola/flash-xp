import 'package:flashxp/features/practice/logic/model/answer_option_button.model.dart';
import 'package:flashxp/features/practice/presentation/widgets/practice_option_button.dart';
import 'package:flutter/material.dart';

class PracticeOptionList extends StatelessWidget {
  final List<AnswerOptionButtonModel> answerOptionButtons;

  const PracticeOptionList({
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
                  child: PracticeOptionButton(
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
