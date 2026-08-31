import 'package:flutter/material.dart';
import 'package:project_management_frontend/core/typography/basic_text.dart';

class TTextNormal extends StatelessWidget {
  final String data;

  final bool bold;

  const TTextNormal(this.data, {this.bold = false, super.key});

  @override
  Widget build(BuildContext context) {
    return BasicText(
      data,
      fontSize: TFontSizes.normal,
      bold: bold,
    );
  }
}
