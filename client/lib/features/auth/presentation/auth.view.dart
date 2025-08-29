import 'package:flashxp/features/auth/logic/auth.controller.dart';
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
  late final AuthController controller;
  bool _isRegister = false;

  void _onControllerUpdated() => setState(() {});

  @override
  void initState() {
    super.initState();
    controller = AuthController(context.read<AuthService>());
    controller.addListener(_onControllerUpdated);
  }

  @override
  void dispose() {
    controller.removeListener(_onControllerUpdated);
    controller.dispose();
    super.dispose();
  }

  Future<void> authenticate(BuildContext context) async {
    final success = await controller.authenticate(context);
    if (success && context.mounted) context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final errorLabel = controller.error != null
        ? Text(
            controller.error!,
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment<bool>(value: false, label: Text('Login')),
                ButtonSegment<bool>(value: true, label: Text('Register')),
              ],
              selected: {_isRegister},
              onSelectionChanged: (s) => setState(() => _isRegister = s.first),
              showSelectedIcon: false,
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, anim) {
                final offsetAnimation = Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOut));
                return SlideTransition(position: offsetAnimation, child: child);
              },
              child: _isRegister
                  ? Column(
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
                    )
                  : Column(
                      key: const ValueKey('login'),
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
                      ],
                    ),
            ),
            errorLabel,
            FlashButton(
              onPressed: () => authenticate(context),
              label: _isRegister ? 'Register' : 'Sign In',
              isBlock: true,
              isLoading: controller.isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
