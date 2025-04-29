import 'package:flutter/material.dart';

// This widget will take a string input and format any part of the string enclosed in ** as bold.
class BoldTextWidget extends StatelessWidget {
  final String text;

  const BoldTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: _parseText(text),
      ),
    );
  }

  // This function will parse the input string and return a list of TextSpans.
  List<TextSpan> _parseText(String input) {
    List<TextSpan> spans = [];
    bool isBold = false;
    StringBuffer currentText = StringBuffer();

    for (int i = 0; i < input.length; i++) {
      String char = input[i];

      // If we encounter a ** (indicating bold), toggle the bold state
      if (char == '*' && i + 1 < input.length && input[i + 1] == '*') {
        // If the current text is not empty, add it to the spans list
        if (currentText.isNotEmpty) {
          spans.add(TextSpan(
              text: currentText.toString(),
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)));
          currentText.clear();
        }
        // Skip the next '*' character
        i++;
        isBold = !isBold; // Toggle the bold state
      } else {
        // Append the current character to the current text
        currentText.write(char);
      }
    }

    // Add any remaining text after parsing
    if (currentText.isNotEmpty) {
      spans.add(TextSpan(
          text: currentText.toString(),
          style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal)));
    }

    return spans;
  }
}
