import 'package:flutter/material.dart';

import '../t_colors.dart';

class TElevatedButton extends StatelessWidget {
  final void Function()? _onPressed;
  final Widget _child;

  const TElevatedButton({required this._onPressed, required this._child, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _onPressed,
      child: _child,
      style: TextButton.styleFrom(
        backgroundColor: TColors.elevatedButton,
      ),
    );
  }
}
