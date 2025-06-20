import 'package:flashxp/shared/logic/service/auth.service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthController extends ChangeNotifier {
  final AuthService authService;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? error;
  bool isLoading = false;

  AuthController(this.authService);

  Future<void> authenticate(BuildContext context) async {
    error = null;
    isLoading = true;
    notifyListeners();

    try {
      await authService.authenticate(
        emailController.text,
        passwordController.text,
      );
      // TODO: handle the warning below
      context.go('/home');
    } catch (e) {
      print(e);
      error = 'Unable to authenticate. Please try again.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
