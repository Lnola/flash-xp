import 'package:flutter/material.dart';

Future<bool> useConfirmationDialog(
  BuildContext context, {
  title,
  text,
  confirmLabel,
  cancelLabel,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        title ?? 'Confirm action',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: Text(
        text ?? 'Are you sure you want to do this action?',
        style: Theme.of(context).textTheme.labelMedium,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            cancelLabel ?? 'No',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            confirmLabel ?? 'Yes',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    ),
  );
  return result ?? false;
}
