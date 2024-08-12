import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomAutoTextSize extends StatelessWidget {
  const CustomAutoTextSize( this.text,
      {super.key,
      this.textAlign,
      required this.style,
      this.maxLines = 1,
      });

  final String text;
  final int maxLines;
  final TextStyle style;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      minFontSize: 8,
      textAlign: textAlign,
      style: style,
      maxLines: maxLines,
    );
  }
}
