import 'package:flutter/material.dart';

import '../../../core/t_colors.dart';
import '../../../core/t_sizes.dart';
import '../../../core/typography/t_text_normal_small.dart';
import '../../../core/typography/t_text_xs.dart';
import '../../../core/widgets/t_icon.dart';
import '../../../core/widgets/text_wrapper.dart';
import '../../../widgets/t_card.dart';
import '../project_model.dart';

class ProjectDetailsProgressPart extends StatelessWidget {
  final ProjectModel _project;

  const ProjectDetailsProgressPart(this._project, {super.key});

  @override
  Widget build(BuildContext context) {
    return TCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TTextNormalSmall('Projektfortschritt'),
              TextWrapper(
                child: TTextXS(
                  (_project.doneRatio ?? '0') + '%',
                  color: TColors.inactive,
                ),
                backgroundColor: TColors.inactiveLight,
              ),
            ],
          ),
          SizedBox(height: TSpacings.p0),
          Row(
            children: [
              Column(
                children: [
                  Container(
                    alignment: AlignmentGeometry.topStart,
                    decoration: BoxDecoration(
                      color: TColors.schemeGlobal,
                      borderRadius: BorderRadius.circular(TSpacings.p1),
                    ),
                    padding: EdgeInsets.fromLTRB(TSpacings.p0half, TSpacings.p0half, TSpacings.p0half, TSpacings.p0half),
                    child: TIcon(
                      Icons.check,
                      size: TIconSizes.small,
                      color: TColors.textWhite,
                    ),
                  ),
                  SizedBox(height: TSpacings.p0half),
                  TTextXS('Ziel'),
                ],
              ),
              _getConnectingLine(color: TColors.schemeGlobal, indent: TSpacings.p0half, endIndent: TSpacings.p0half),
              Column(
                children: [
                  Container(
                    alignment: AlignmentGeometry.topStart,
                    decoration: BoxDecoration(
                      color: TColors.schemeGlobal,
                      borderRadius: BorderRadius.circular(TSpacings.p1),
                    ),
                    padding: EdgeInsets.fromLTRB(TSpacings.p0half, TSpacings.p0half, TSpacings.p0half, TSpacings.p0half),
                    child: TIcon(
                      Icons.psychology,
                      size: TIconSizes.small,
                      color: TColors.textWhite,
                    ),
                  ),
                  SizedBox(height: TSpacings.p0half),
                  TTextXS('Plan'),
                ],
              ),
              _getConnectingLine(color: TColors.schemeGlobal, indent: TSpacings.p0half),
              Column(
                children: [
                  Container(
                    alignment: AlignmentGeometry.topStart,
                    decoration: BoxDecoration(
                      color: TColors.schemeGlobal,
                      borderRadius: BorderRadius.circular(TSpacings.p1),
                    ),
                    padding: EdgeInsets.fromLTRB(TSpacings.p0half, TSpacings.p0half, TSpacings.p0half, TSpacings.p0half),
                    child: TIcon(
                      Icons.crisis_alert,
                      size: TIconSizes.small,
                      color: TColors.textWhite,
                    ),
                  ),
                  SizedBox(height: TSpacings.p0half),
                  TTextXS('Entsch.'),
                ],
              ),
              _getConnectingLine(color: TColors.schemeGlobal),
              Column(
                children: [
                  Container(
                    alignment: AlignmentGeometry.topStart,
                    decoration: BoxDecoration(
                      color: TColors.schemeGlobal,
                      borderRadius: BorderRadius.circular(TSpacings.p1),
                    ),
                    padding: EdgeInsets.fromLTRB(TSpacings.p0half, TSpacings.p0half, TSpacings.p0half, TSpacings.p0half),
                    child: TIcon(
                      Icons.checklist,
                      size: TIconSizes.small,
                      color: TColors.textWhite,
                    ),
                  ),
                  SizedBox(height: TSpacings.p0half),
                  TTextXS('ToDos'),
                ],
              ),
              _getConnectingLine(color: TColors.schemeGlobal),
              Column(
                children: [
                  Container(
                    alignment: AlignmentGeometry.topStart,
                    decoration: BoxDecoration(
                      color: TColors.schemeGlobal,
                      borderRadius: BorderRadius.circular(TSpacings.p1),
                    ),
                    padding: EdgeInsets.fromLTRB(TSpacings.p0half, TSpacings.p0half, TSpacings.p0half, TSpacings.p0half),
                    child: TIcon(
                      Icons.event_repeat,
                      size: TIconSizes.small,
                      color: TColors.textWhite,
                    ),
                  ),
                  SizedBox(height: TSpacings.p0half),
                  TTextXS('Check'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getConnectingLine({required Color color, double? indent = null, double? endIndent = null}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: TSpacings.p1),
        child: Divider(
          height: TSpacings.p4,
          indent: indent,
          endIndent: endIndent,
          thickness: 1.5,
          color: color,
        ),
      ),
    );
  }
}
