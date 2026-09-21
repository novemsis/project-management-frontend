import 'package:flutter/material.dart';

import '../t_colors.dart';
import 'basic_text.dart';

class TTextLarge extends StatelessWidget {
  final String _data;
  final Color _color;

  const TTextLarge(this._data, {this._color = TColors.textPrimary, super.key});

  @override
  Widget build(BuildContext context) {
    return BasicText(
      _data,
      fontSize: TFontSizes.headline,
      color: _color,
    );
  }
}
