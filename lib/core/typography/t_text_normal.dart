import 'package:flutter/material.dart';

import '../t_colors.dart';
import 'basic_text.dart';

class TTextNormal extends StatelessWidget {
  final String data;
  final bool? bold;
  final Color? _color;

  const TTextNormal(this.data, {this.bold = false, this._color = TColors.textPrimary, super.key});

  @override
  Widget build(BuildContext context) {
    return BasicText(
      data,
      fontSize: TFontSizes.normal,
      fontWeight: (bold ?? false) ? 700 : 400,
      color: _color ?? TColors.textPrimary,
    );
  }
}
