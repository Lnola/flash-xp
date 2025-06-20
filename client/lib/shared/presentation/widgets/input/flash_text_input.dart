import 'package:flutter/material.dart';

class FlashTextInput extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;

  const FlashTextInput({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false,
  });

  @override
  State<FlashTextInput> createState() => _FlashTextInputState();
}

class _FlashTextInputState extends State<FlashTextInput> {
  late final FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (mounted) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final passwordConfig = widget.isPassword
        ? (keyboardType: TextInputType.text, maxLines: 1)
        : (keyboardType: TextInputType.multiline, maxLines: null);

    return GestureDetector(
      onTap: () => _focusNode.requestFocus(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isFocused
                ? theme.colorScheme.primary
                : theme.colorScheme.outline.withAlpha(77),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withAlpha(77),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              keyboardType: passwordConfig.keyboardType,
              maxLines: passwordConfig.maxLines,
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              obscureText: widget.isPassword,
              enableSuggestions: !widget.isPassword,
              autocorrect: !widget.isPassword,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
