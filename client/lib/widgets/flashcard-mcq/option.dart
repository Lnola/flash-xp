import 'package:flutter/material.dart';

class Option extends StatelessWidget {
  final String option;
  final bool isAnswered;
  final bool isCorrect;
  final bool isSelected;
  final void Function(String) onTap;

  const Option({
    super.key,
    required this.option,
    required this.isAnswered,
    required this.isCorrect,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var color = isAnswered
        ? (isCorrect ? Colors.green : (isSelected ? Colors.red : Colors.white))
        : Colors.blue.shade100;

    return GestureDetector(
      onTap: () => onTap(option),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blue, width: 2),
        ),
        child: Text(
          option,
          style: TextStyle(fontSize: 18, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
