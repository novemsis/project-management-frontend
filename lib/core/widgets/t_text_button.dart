import 'package:flutter/material.dart';

import '../t_sizes.dart';

class TTextButton extends StatelessWidget {
  final void Function()? _onPressed;
  final Widget child;

  const TTextButton({required this._onPressed, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _onPressed,
      child: child,
      style: TextButton.styleFrom(
        padding: EdgeInsets.fromLTRB(TSpacings.p1, 0, TSpacings.p1, 0),
      ),
    );
  }
}
