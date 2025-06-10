import 'package:flashxp/shared/presentation/widgets/utils/if.dart';
import 'package:flutter/material.dart';

class FlashInputGroup extends StatelessWidget {
  final List<Widget> children;
  final VoidCallback? onRemove;

  const FlashInputGroup({
    super.key,
    required this.children,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Column(children: children)),
          If(
            condition: onRemove != null,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: onRemove,
            ),
          ),
        ],
      ),
    );
  }
}
