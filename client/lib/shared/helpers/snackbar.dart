import 'package:flutter/material.dart';

void useSnackbar(BuildContext context, String? error, String? message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(error ?? message!),
      backgroundColor: error == null
          ? Theme.of(context).colorScheme.tertiary
          : Theme.of(context).colorScheme.error,
    ),
  );
}
