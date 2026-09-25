import 'package:flutter/material.dart';

import 't_colors.dart';
import 't_sizes.dart';
import 'typography/t_text_small.dart';
import 'widgets/t_icon.dart';

class TSnackBar {
  static void success(
    BuildContext context,
    String message,
  ) {
    _show(
      context,
      message: message,
      icon: Icons.check_rounded,
      iconColor: TColors.success,
      iconBackground: TColors.successLight,
    );
  }

  static void error(
    BuildContext context,
    String message,
  ) => _show(
    context,
    message: message,
    icon: Icons.error_outline_rounded,
    iconColor: TColors.error,
    iconBackground: TColors.errorLight,
  );

  static void _show(
    BuildContext context, {
    required String message,
    required IconData icon,
    required Color iconColor,
    required Color iconBackground,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(TSpacings.p0),
                  child: TIcon(
                    icon,
                    color: iconColor,
                  ),
                ),
              ),
              const SizedBox(width: TSpacings.p1half),
              Expanded(
                child: TTextSmall(
                  message,
                  color: TColors.textPrimary,
                ),
              ),
            ],
          ),
          duration: const Duration(seconds: 6),
          backgroundColor: TColors.cardBackground,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.fromLTRB(TSpacings.p1, 0, TSpacings.p1, TSpacings.p9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(TSpacings.p1half),
          ),
        ),
      );
  }
}
