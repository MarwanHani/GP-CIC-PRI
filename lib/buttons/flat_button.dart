import 'package:flutter/material.dart';

class flatButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color textColor;

  flatButton(
      {required this.text, required this.onPressed, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextButton(
        style: TextButton.styleFrom(
          primary: textColor,
          textStyle: const TextStyle(fontSize: 18),
        ),
        onPressed: () {},
        child: Text(text),
      ),
    );
  }
}
