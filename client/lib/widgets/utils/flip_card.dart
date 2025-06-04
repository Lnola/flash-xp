import 'dart:math';

import 'package:flutter/material.dart';

class FlipCard extends StatelessWidget {
  final Widget front;
  final Widget back;
  final bool flipped;
  final Duration duration;

  const FlipCard({
    super.key,
    required this.front,
    required this.back,
    required this.flipped,
    this.duration = const Duration(milliseconds: 400),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: flipped ? pi : 0, end: flipped ? pi : 0),
      duration: duration,
      builder: (context, angle, _) {
        final transform = Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(angle);

        return Transform(
          alignment: Alignment.center,
          transform: transform,
          child: Stack(
            children: [
              Visibility(
                visible: angle <= pi / 2,
                child: front,
              ),
              Visibility(
                visible: angle > pi / 2,
                child: Transform(
                  transform: Matrix4.identity()..rotateY(pi),
                  alignment: Alignment.center,
                  child: back,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
