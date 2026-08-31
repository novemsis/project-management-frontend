import 'package:flutter/material.dart';

import '../core/t_sizes.dart';
import '../core/typography/t_text_normal.dart';
import '../widgets/t_card.dart';

class HomeProjectWidget extends StatelessWidget {
  const HomeProjectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: TSpacings.p1),
      child: TCard(
        child: Column(
          spacing: TSpacings.p0half,
          children: [
            TTextNormal(
              'Project One',
              bold: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TTextNormal('Ziel:'),
                Icon(Icons.check, size: TIconSizes.small),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TTextNormal('Plan:'),
                Icon(Icons.warning_amber_rounded, size: TIconSizes.small),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TTextNormal('Entschluss:'),
                Icon(Icons.check, size: TIconSizes.small),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TTextNormal('Umsetzung:'),
                TTextNormal('56%'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TTextNormal('Kontrolle:'),
                TTextNormal('07.09.2000'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
