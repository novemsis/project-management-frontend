import 'package:flutter/material.dart';
import 'package:project_management_frontend/core/typography/basic_text.dart';

class TTextLarge extends StatelessWidget {
  final String data;

  const TTextLarge(
      this.data, {
        super.key
      });

  @override
  Widget build(BuildContext context) {
    return BasicText(
      data,
      fontSize: TFontSizes.headline,
    );
  }
}