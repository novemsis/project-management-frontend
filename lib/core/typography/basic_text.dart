import 'package:flutter/material.dart';

import '../t_colors.dart';

class BasicText extends StatelessWidget {
  final String data;
  final Color? color;
  final double fontSize;
  final int fontWeight;
  final TextOverflow textOverflow;

  const BasicText(
    this.data, {
    this.color = TColors.textPrimary,
    this.fontSize = TFontSizes.normal,
    this.fontWeight = 400,
    this.textOverflow = TextOverflow.ellipsis,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        inherit: false,
        color: color,
        fontWeight: FontWeight(fontWeight),
        fontSize: 20 * fontSize,
        overflow: textOverflow,
      ),
    );
  }
}

class TFontSizes {
  static const double headline = 1.5;
  static const double normal = 1;
  static const double normal_small = 0.8;
  static const double small = 0.7;
  static const double xs = 0.6;
}
