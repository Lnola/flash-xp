import 'package:flutter/widgets.dart';

class If extends StatelessWidget {
  final bool condition;
  final Widget? child;
  final Widget Function(BuildContext context)? builder;

  const If({
    super.key,
    required this.condition,
    this.child,
    this.builder,
  });

  @override
  Widget build(BuildContext context) {
    if (!condition) return const SizedBox.shrink();
    if (child != null) return child!;
    if (builder != null) return builder!(context);
    throw ArgumentError('Either child or builder must be provided');
  }
}
