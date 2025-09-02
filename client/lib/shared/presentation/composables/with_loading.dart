import 'package:flashxp/shared/presentation/widgets/flash_loading.dart';
import 'package:flutter/material.dart';

Future<T> withLoading<T>(
  BuildContext context,
  Future<T> Function() task, {
  String message = 'Loading...',
}) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => _Loading(message: message),
  );
  final startTime = DateTime.now();
  final minimumLoadingDuration = const Duration(seconds: 1);
  try {
    final r = await task();
    final elapsed = DateTime.now().difference(startTime);
    if (elapsed < minimumLoadingDuration) {
      await Future.delayed(minimumLoadingDuration - elapsed);
    }
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
      backgroundColor: Colors.transparent,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 32,
        children: [
          FlashLoading(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            width: 48,
            height: 48,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
          ),
        ],
      ),
    );
  }
}
