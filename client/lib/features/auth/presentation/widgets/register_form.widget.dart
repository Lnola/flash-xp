import 'package:flashxp/features/auth/logic/auth.controller.dart';
import 'package:flashxp/shared/presentation/widgets/input/flash_text_input.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
    required this.controller,
    required TextEditingController confirmPasswordController,
  }) : _confirmPasswordController = confirmPasswordController;

  final AuthController controller;
  final TextEditingController _confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('register'),
      spacing: 16,
      children: [
        FlashTextInput(
          controller: controller.emailController,
          label: 'Email',
          keyboardType: TextInputType.emailAddress,
        ),
        FlashTextInput(
          controller: controller.passwordController,
          label: 'Password',
          isPassword: true,
        ),
        FlashTextInput(
          controller: _confirmPasswordController,
          label: 'Confirm Password',
          isPassword: true,
        ),
      ],
    );
  }
}
