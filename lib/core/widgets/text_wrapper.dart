import 'package:flutter/material.dart';

import '../t_sizes.dart';

class TextWrapper extends StatelessWidget {
  final Widget _child;
  final Color _backgroundColor;

  const TextWrapper({required this._child, required this._backgroundColor, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(TSpacings.p1),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(TSpacings.p1half, TSpacings.p0half, TSpacings.p1half, TSpacings.p0half),
        child: _child,
      ),
    );
  }
}
