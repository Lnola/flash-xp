import 'package:flashxp/shared/helpers/result.dart';
import 'package:flashxp/shared/presentation/composables/snackbar.dart';
import 'package:flashxp/shared/presentation/composables/with_loading.dart';
import 'package:flashxp/shared/presentation/widgets/flash_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthoringFormActionsWidget extends StatelessWidget {
  final Future<Result<void>> Function() generateQuestions;
  final void Function() addQuestion;
  final void Function(BuildContext) submit;

  const AuthoringFormActionsWidget({
    super.key,
    required this.generateQuestions,
    required this.addQuestion,
    required this.submit,
  });

  void _generateQuestions(BuildContext context) async {
    final result = await withLoading(
      context,
      generateQuestions,
      message: 'Generating questions from your pdf file...',
    );
    if (!context.mounted) return;
    if (result.error != null) {
      return useSnackbar(context, result.error, 'Failed to generate questions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FlashIconButton(
          onPressed: () => _generateQuestions(context),
          label: 'AI',
          icon: FontAwesomeIcons.wandMagicSparkles,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FlashIconButton(
              onPressed: addQuestion,
              label: 'Add Input',
              icon: FontAwesomeIcons.plus,
            ),
            const SizedBox(width: 12),
            FlashIconButton(
              onPressed: () => submit(context),
              label: 'Submit',
              icon: FontAwesomeIcons.check,
            ),
          ],
        ),
      ],
    );
  }
}
