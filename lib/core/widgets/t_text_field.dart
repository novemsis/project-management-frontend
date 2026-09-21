import 'package:flutter/material.dart';

import '../t_colors.dart';

class TTextfield extends StatelessWidget {
  final String? _labelText;
  final bool _obscureText;

  const TTextfield({
    this._labelText,
    this._obscureText = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: TColors.textFieldBackground,
        labelText: _labelText,
      ),
    );
  }
}
