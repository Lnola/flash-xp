import 'package:flashxp/shared/logic/service/auth.service.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  final AuthService authService;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String? error;
  bool isLoading = false;
  bool isRegister = false;

  AuthController(this.authService);

  Future<bool> authenticate(BuildContext context) async {
    error = null;
    isLoading = true;
    notifyListeners();

    try {
      await authService.authenticate(
        isRegister,
        emailController.text,
        passwordController.text,
        confirmPasswordController.text,
      );
      return true;
    } catch (e) {
      if (e is AuthException) {
        error = e.toString();
      } else {
        error = 'Unable to authenticate. Please try again.';
      }
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void toggleMode(bool value) {
    isRegister = value;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
