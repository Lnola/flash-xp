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
  bool isLoading = false;

  void _authenticate() async {
    try {
      setState(() {
        error = null;
        isLoading = true;
      });
      final authService = context.read<AuthService>();
      await authService.authenticate(
        emailController.text,
        passwordController.text,
      );
      // TODO: Handle correct navigation
      context.go('/home');
    } catch (e) {
      print(e);
      setState(() => error = 'Unable to authenticate. Please try again.');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final errorLabel = error != null
        ? Text(
            error!,
            style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(color: Colors.red),
          )
        : const SizedBox(height: 15);

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
              isPassword: true,
            ),
            errorLabel,
            FlashButton(
              onPressed: _authenticate,
              label: 'Sign In',
              isBlock: true,
              isLoading: isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
