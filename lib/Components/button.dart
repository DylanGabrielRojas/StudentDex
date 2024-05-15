import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  const ButtonComponent({super.key, required this.text, required this.textColor, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: ElevatedButton(
        onPressed: null,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(backgroundColor),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
          