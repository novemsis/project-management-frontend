import 'package:flutter/material.dart';

import '../t_colors.dart';
import '../t_sizes.dart';
import '../typography/t_text_small.dart';

class TTextfield extends StatelessWidget {
  final String? _labelText;
  final bool _obscureText;
  final bool _isMandatory;
  final int? _maxLines;
  final int? _minLines;
  final int? _maxLength;

  const TTextfield({
    this._labelText,
    this._minLines,
    this._maxLength,
    this._obscureText = false,
    this._isMandatory = false,
    this._maxLines = 1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: TColors.textFieldBackground,
        label: _getLabel(),
      ),
      maxLines: _maxLines,
      minLines: _minLines,
      maxLength: _maxLength,
    );
  }

  Widget? _getLabel() {
    if (_labelText == null) {
      return null;
    }

    return switch (_isMandatory) {
      false => TTextSmall(_labelText),
      true => Row(
        children: [
          TTextSmall(_labelText),
          SizedBox(width: TSpacings.p0half),
          TTextSmall(
            '*',
            bold: true,
            color: TColors.error,
          ),
        ],
      ),
    };
  }
}
