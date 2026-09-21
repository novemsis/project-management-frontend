import 'package:flutter/material.dart';

import '../core/t_colors.dart';
import '../core/t_sizes.dart';

class TCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const TCard({required this.child, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: onTap != null
          ? InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(TSpacings.p1, TSpacings.p0, TSpacings.p1, TSpacings.p0),
                child: child,
              ),
            )
          : Padding(
              padding: const EdgeInsets.fromLTRB(TSpacings.p1, TSpacings.p0, TSpacings.p1, TSpacings.p0),
              child: child,
            ),
      color: TColors.card,
    );
  }
}
