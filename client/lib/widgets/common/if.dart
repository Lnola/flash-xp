import 'package:flutter/widgets.dart';

class If extends StatelessWidget {
  final bool condition;
  final Widget Function(BuildContext context) builder;

  const If({
    super.key,
    required this.condition,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return condition ? builder(context) : const SizedBox.shrink();
  }
}
