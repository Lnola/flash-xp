import 'package:flashxp/shared/logic/service/auth.service.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  final AuthService authService;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? error;
  bool isLoading = false;

  AuthController(this.authService);

  Future<bool> authenticate(BuildContext context) async {
    error = null;
    isLoading = true;
    notifyListeners();

    try {
      await authService.authenticate(
        emailController.text,
        passwordController.text,
      );
      return true;
    } catch (e) {
      print(e);
      error = 'Unable to authenticate. Please try again.';
      return false;
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
