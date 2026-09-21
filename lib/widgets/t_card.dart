import 'package:flutter/material.dart';

import '../core/t_colors.dart';
import '../core/t_sizes.dart';

class TCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const TCard({required this.child, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: TColors.cardBackground,
        borderRadius: BorderRadius.circular(TSpacings.p2half),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: TSpacings.p2half,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(TSpacings.p2half),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(TSpacings.p2half),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(TSpacings.p1, TSpacings.p0, TSpacings.p1, TSpacings.p0),
            child: child,
          ),
        ),
      ),
    );
  }
}
