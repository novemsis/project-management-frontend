import 'package:flutter/material.dart';

import '../t_colors.dart';

class BasicText extends StatelessWidget {
  final String data;
  final Color? color;
  final double fontSize;

  final bool bold;

  const BasicText(this.data, {this.color = TColors.textGlobal, this.fontSize = TFontSizes.normal, this.bold = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        inherit: false,
        color: color,
        fontWeight: bold ? FontWeight(800) : FontWeight(400),
        fontSize: 20 * fontSize,
      ),
    );
  }
}

class TFontSizes {
  static const double headline = 1.5;
  static const double normal = 1;
}
