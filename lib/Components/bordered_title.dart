import 'package:flutter/material.dart';

class BorderedTitle extends StatelessWidget {
  const BorderedTitle({
    super.key, 
    required this.title,
    required this.titleSize,
    });

  final String title;
  final double titleSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: "josephsophia",
              fontSize: titleSize,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 3
                ..color = Colors.black,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "josephsophia",
              fontSize: titleSize,
            ),
          ),
        ],
      );
  }
}