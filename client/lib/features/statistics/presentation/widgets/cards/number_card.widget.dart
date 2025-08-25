import 'package:flashxp/shared/helpers/snackbar.dart';
import 'package:flashxp/shared/presentation/widgets/utils/if.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NumberCardWidget extends StatelessWidget {
  final int? value;
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;
  final bool isLoading;
  final String? error;

  const NumberCardWidget({
    super.key,
    required this.value,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.isLoading = false,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) return _SkeletonLoader();
    if (error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        useSnackbar(context, error, null);
      });
    }

    final textColor = this.textColor ?? Theme.of(context).colorScheme.onSurface;
    final localValue = value?.toString() ?? '0';
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _Value(icon: icon, value: localValue, textColor: textColor),
          _Label(label: label, textColor: textColor),
        ],
      ),
    );
  }
}

class _Value extends StatelessWidget {
  final IconData? icon;
  final String value;
  final Color textColor;

  const _Value({
    required this.icon,
    required this.value,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        If(
          condition: icon != null,
          child: Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: FaIcon(icon, size: 16),
          ),
        ),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: textColor),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _Label extends StatelessWidget {
  final String label;
  final Color textColor;

  const _Label({
    required this.label,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context)
          .textTheme
          .bodySmall
          ?.copyWith(color: textColor.withAlpha(77)),
      textAlign: TextAlign.center,
    );
  }
}

class _SkeletonLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget skeletonBox({double? height, double? width, bool rounded = false}) {
      return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer.withAlpha(33),
          borderRadius:
              rounded ? BorderRadius.circular(1000) : BorderRadius.circular(8),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withAlpha(99),
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              skeletonBox(height: 28, width: 60),
              const SizedBox(height: 13),
              skeletonBox(height: 16, width: 80),
            ],
          ),
        ],
      ),
    );
  }
}
