import 'package:flutter/material.dart';

import '../t_colors.dart';
import 'basic_text.dart';

class TTextXXS extends StatelessWidget {
  final String _data;
  final bool _bold;
  final Color? _color;

  const TTextXXS(this._data, {this._bold = false, this._color = TColors.textSecondary, super.key});

  @override
  Widget build(BuildContext context) {
    return BasicText(
      _data,
      fontSize: TFontSizes.xs,
      fontWeight: _bold ? 600 : 400,
      color: _color ?? TColors.textSecondary,
    );
  }
}
