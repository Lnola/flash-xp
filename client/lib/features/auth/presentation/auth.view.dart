import 'package:flashxp/shared/logic/service/auth.service.dart';
import 'package:flashxp/shared/presentation/widgets/flash_button.dart';
import 'package:flashxp/shared/presentation/widgets/input/flash_text_input.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? error;

  void _authenticate() async {
    try {
      final authService = context.read<AuthService>();
      await authService.authenticate(
        emailController.text,
        passwordController.text,
      );
      context.go('/home');
    } catch (e) {
      print(e);
      setState(() => error = 'Unable to authenticate. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            FlashTextInput(
              controller: emailController,
              label: 'Email',
            ),
            FlashTextInput(
              controller: passwordController,
              label: 'Password',
            ),
            if (error != null)
              Text(error!, style: const TextStyle(color: Colors.red)),
            FlashButton(
              onPressed: _authenticate,
              label: 'Sign In',
              isBlock: true,
            ),
          ],
        ),
      ),
    );
  }
}
