import 'package:flutter/material.dart';

import '../../../core/t_colors.dart';
import '../../../core/t_sizes.dart';
import '../../../core/typography/t_text_small.dart';
import '../../../core/typography/t_text_xxs.dart';
import '../../../core/widgets/t_icon.dart';
import '../../../core/widgets/text_wrapper.dart';
import '../../../widgets/t_card.dart';
import '../project_model.dart';

class ProjectDetailsDecisionPart extends StatelessWidget {
  final ProjectModel _project;

  const ProjectDetailsDecisionPart(this._project, {super.key});

  @override
  Widget build(BuildContext context) {
    return TCard(
      // ToDo: implement decision dialog (only if decision exists)
      onTap: () => print('open decision dialog'),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TTextSmall('Entscheidung'),
              if (_project.decision != null)
                TIcon(
                  Icons.chevron_right,
                  color: TColors.textPrimary,
                  size: TIconSizes.small,
                ),
            ],
          ),
          if (_project.decision != null) ...[
            SizedBox(height: TSpacings.p0),
            ..._getExistingDecisionContent(),
          ] else ...[
            InkWell(
              // ToDo: add decision
              onTap: () => print('make a decision'),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(TSpacings.p1),
                  border: BoxBorder.all(color: TColors.schemeGlobal),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(TSpacings.p0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TIcon(Icons.add, size: TIconSizes.xs),
                      SizedBox(width: TSpacings.p0),
                      TTextXXS('make a decision', color: TColors.schemeGlobal),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: TSpacings.p0),
          ],
        ],
      ),
    );
  }

  List<Widget> _getExistingDecisionContent() {
    return [
      if (_project.decision!.description != null)
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TTextXXS('Description', color: TColors.schemeGlobal),
                TTextXXS(_project.decision!.description!),
              ],
            ),
          ],
        ),
      SizedBox(height: TSpacings.p1),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWrapper(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: TSpacings.p0, horizontal: TSpacings.p0),
              child: Row(
                children: [
                  TIcon(
                    _project.decision!.carryThrough ? Icons.check : Icons.close,
                    size: TIconSizes.xs,
                    color: _project.decision!.carryThrough ? TColors.success : TColors.error,
                  ),
                  SizedBox(width: TSpacings.p0quarter),
                  TTextXXS(
                    _project.decision!.carryThrough ? 'wird umgesetzt' : 'wird nicht umgesetzt',
                    color: _project.decision!.carryThrough ? TColors.success : TColors.error,
                    bold: true,
                  ),
                ],
              ),
            ),
            backgroundColor: _project.decision!.carryThrough ? TColors.successLight : TColors.errorLight,
          ),
        ],
      ),
      SizedBox(height: TSpacings.p0),
    ];
  }
}
