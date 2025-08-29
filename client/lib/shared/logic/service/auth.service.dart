import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  final String message;
  const AuthException(this.message);

  @override
  String toString() => message;
}

class AuthService with ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  User? get user => _auth.currentUser;

  bool get isSignedIn => user != null;

  Future<void> authenticate(
    bool isRegister,
    String email,
    String password,
    String confirmPassword,
  ) async {
    if (isRegister) {
      return await _register(email, password, confirmPassword);
    }
    return await _signIn(email, password);
  }

  Future<void> _signIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    notifyListeners();
  }

  Future<void> _register(
    String email,
    String password,
    String confirmPassword,
  ) async {
    if (password != confirmPassword) {
      throw const AuthException('Passwords do not match.');
    }
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    notifyListeners();
  }

  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }
}
