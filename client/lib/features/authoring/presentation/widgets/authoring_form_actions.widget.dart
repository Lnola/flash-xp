import 'package:flashxp/shared/presentation/widgets/flash_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthoringFormActionsWidget extends StatelessWidget {
  final void Function() addQuestion;
  final void Function(BuildContext) submit;

  const AuthoringFormActionsWidget({
    super.key,
    required this.addQuestion,
    required this.submit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
