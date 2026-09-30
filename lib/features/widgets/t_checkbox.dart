import 'package:flutter/material.dart';

import '../../core/t_colors.dart';
import '../../core/t_sizes.dart';

class TCheckbox extends StatelessWidget {
  final bool _isActive;
  final Widget? _text;
  final Color _activeBackgroundColor;
  final void Function(bool?) _onChanged;

  const TCheckbox({
    required this._onChanged,
    this._isActive = false,
    this._text,
    this._activeBackgroundColor = TColors.schemeGlobalBackground,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: _isActive,
          onChanged: _onChanged,
          activeColor: _activeBackgroundColor,
          checkColor: TColors.schemeGlobal,
          side: BorderSide(
            color: TColors.schemeGlobal,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(TSpacings.p0half),
          ),
          visualDensity: VisualDensity(vertical: -3, horizontal: -3),
        ),
        if (_text != null) SizedBox(width: 0), //TSpacings.p0),
        if (_text != null) _text,
      ],
    );
  }
}
