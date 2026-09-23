import 'package:flutter/material.dart';

import '../t_colors.dart';
import '../t_sizes.dart';

class TIcon extends StatelessWidget {
  final IconData _icon;
  final double _size;
  final Color _color;

  const TIcon(this._icon, {this._size = TIconSizes.normal, this._color = TColors.schemeGlobal, super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      _icon,
      size: _size,
      color: _color,
    );
  }
}
