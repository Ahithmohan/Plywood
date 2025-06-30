import 'package:flutter/material.dart';

class BuildTextWidget extends StatelessWidget {
  final String text;
  final int? maxLines;
  final TextAlign? align;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextOverflow? textOverflow;
  const BuildTextWidget(
      {super.key,
      required this.text,
      this.color,
      this.fontSize,
      this.fontWeight,
      this.textOverflow,
      this.align,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: maxLines,
      overflow: textOverflow,
      text,
      textAlign: align,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}
