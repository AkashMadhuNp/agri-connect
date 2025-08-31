import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final double fontSize;

  const SectionHeader({
    Key? key,
    required this.title,
    this.buttonText,
    this.onButtonPressed,
    this.fontSize = 18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2D3142),
          ),
        ),
        if (buttonText != null)
          TextButton(
            onPressed: onButtonPressed,
            child: Text(buttonText!),
          ),
      ],
    );
  }
}