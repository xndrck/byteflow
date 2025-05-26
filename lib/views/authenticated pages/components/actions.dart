import 'package:flutter/material.dart';
import 'package:byte_flow/main.dart';

class JActions extends StatelessWidget {
  final String? image;
  final String? text;
  final ThemeProvider themeProvider;

  const JActions(
      {super.key,
      required this.image,
      required this.text,
      required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                color: themeProvider.themeMode == ThemeMode.light
                    ? Colors.white
                    : Colors.white.withOpacity(0.9),
                shape: BoxShape.circle),
            child: Image.asset(image!)),
        Text(
          text!,
          style:
              TextStyle(color: themeProvider.containerTextColor, fontSize: 10),
        )
      ],
    );
  }
}
