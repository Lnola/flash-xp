import 'package:flutter/material.dart';

import 'option.dart';

class OptionList extends StatefulWidget {
  final List<String> options;
  final String correctOption;
  final VoidCallback onNext;

  const OptionList({
    super.key,
    required this.options,
    required this.correctOption,
    required this.onNext,
  });

  @override
  OptionListState createState() => OptionListState();
}

class OptionListState extends State<OptionList> {
  String? selectedOption;
  bool isAnswered = false;

  void _checkAnswer(String answer) {
    if (isAnswered) return;
    setState(() {
      selectedOption = answer;
      isAnswered = true;
    });
    Future.delayed(Duration(seconds: 1), widget.onNext);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: widget.options.map((option) {
              var isCorrect = option == widget.correctOption;
              var isSelected = option == selectedOption;
              return Option(
                option: option,
                isAnswered: isAnswered,
                isCorrect: isCorrect,
                isSelected: isSelected,
                onTap: _checkAnswer,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
