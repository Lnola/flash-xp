import 'package:flutter/material.dart';

Future<T> withLoading<T>(
  BuildContext context,
  Future<T> Function() task, {
  String message = 'Loading...',
}) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const _Loading(message: 'Loading...'),
  );
  try {
    final r = await task();
    return r;
  } finally {
    if (context.mounted) Navigator.of(context, rootNavigator: true).pop();
  }
}

class _Loading extends StatelessWidget {
  final String message;
  const _Loading({required this.message});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        children: [
          const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          const SizedBox(width: 12),
          Text(message),
        ],
      ),
    );
  }
}
