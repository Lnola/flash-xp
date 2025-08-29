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

  Future<void> authenticate(String email, String password) async {
    try {
      await _signIn(email, password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        try {
          await _register(email, password);
        } on FirebaseAuthException catch (_) {
          rethrow;
        }
      } else {
        rethrow;
      }
    }
  }

  Future<void> _signIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    notifyListeners();
  }

  Future<void> _register(String email, String password) async {
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
