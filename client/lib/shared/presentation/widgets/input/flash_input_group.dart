import 'package:flutter/material.dart';

// TODO: make this optionally removable
class FlashInputGroup extends StatelessWidget {
  final List<Widget> children;
  final VoidCallback onRemove;

  const FlashInputGroup({
    super.key,
    required this.children,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(children: children),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}
