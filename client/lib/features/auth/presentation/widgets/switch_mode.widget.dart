import 'package:flashxp/features/auth/logic/auth.controller.dart';
import 'package:flutter/material.dart';

class SwitchMode extends StatelessWidget {
  const SwitchMode({
    super.key,
    required this.controller,
  });

  final AuthController controller;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<bool>(
      segments: const [
        ButtonSegment<bool>(value: false, label: Text('Sign In')),
        ButtonSegment<bool>(value: true, label: Text('Register')),
      ],
      selected: {controller.isRegister},
      onSelectionChanged: (s) => controller.toggleMode(s.first),
      showSelectedIcon: false,
    );
  }
}
