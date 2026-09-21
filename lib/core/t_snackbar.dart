import 'package:flutter/material.dart';

import 't_colors.dart';
import 'typography/t_text_normal.dart';

class TSnackBar {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> displayText(
    BuildContext context,
    String message,
  ) => ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Expanded(child: TTextNormal(message)),
      duration: const Duration(seconds: 6),
      backgroundColor: TColors.snackBarBackground,
    ),
  );
}
