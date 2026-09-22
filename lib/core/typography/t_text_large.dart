import 'package:flutter/material.dart';

import '../t_colors.dart';
import 'basic_text.dart';

class TTextLarge extends StatelessWidget {
  final String _data;
  final Color _color;
  final bool _bold;

  const TTextLarge(this._data, {this._color = TColors.textPrimary, this._bold = false, super.key});

  @override
  Widget build(BuildContext context) {
    return BasicText(
      _data,
      fontSize: TFontSizes.headline,
      fontWeight: _bold ? 700 : 400,
      color: _color,
    );
  }
}
