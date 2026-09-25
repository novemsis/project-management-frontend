import 'package:flutter/material.dart';

import '../t_colors.dart';
import 'basic_text.dart';

class TTextSmall extends StatelessWidget {
  final String data;
  final bool? bold;
  final Color? _color;

  const TTextSmall(this.data, {this.bold = false, this._color = TColors.textPrimary, super.key});

  @override
  Widget build(BuildContext context) {
    return BasicText(
      data,
      fontSize: TFontSizes.normal_small,
      fontWeight: (bold ?? false) ? 700 : 400,
      color: _color ?? TColors.textPrimary,
    );
  }
}
