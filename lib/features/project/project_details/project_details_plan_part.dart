import 'package:flutter/material.dart';

import '../../../core/t_colors.dart';
import '../../../core/t_sizes.dart';
import '../../../core/typography/t_text_normal_small.dart';
import '../../../core/typography/t_text_xs.dart';
import '../../../core/widgets/t_icon.dart';
import '../../../widgets/t_card.dart';
import '../project_model.dart';

class ProjectDetailsPlanPart extends StatelessWidget {
  final ProjectModel _project;

  const ProjectDetailsPlanPart(this._project, {super.key});

  @override
  Widget build(BuildContext context) {
    return TCard(
      child: Column(
        children: [
          Row(children: [TTextNormalSmall('Plan')]),
          if (_project.plan != null) ...[
            SizedBox(height: TSpacings.p0),
            _getExistingPlanContend(),
          ] else ...[
            InkWell(
              // ToDo: add Plan
              onTap: () => print('add Plan'),
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
                      TIcon(Icons.add, size: TIconSizes.small),
                      SizedBox(width: TSpacings.p0),
                      TTextXS('Plan hinzufügen', color: TColors.schemeGlobal),
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

  Widget _getExistingPlanContend() {
    return Row(
      children: [
        SizedBox(
          width: 320,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TTextXS('Strategische Definition', color: TColors.schemeGlobal),
              TTextXS(_project.plan!.strategicDefinition != null ? '"${_project.plan!.strategicDefinition!.trim()}"' : '-'),
              SizedBox(height: TSpacings.p0),
              TTextXS('Taktische Definition', color: TColors.schemeGlobal),
              TTextXS(_project.plan!.tacticalDefinition != null ? '"${_project.plan!.tacticalDefinition!.trim()}"' : '-'),
              SizedBox(height: TSpacings.p0),
              TTextXS('Operative Definition', color: TColors.schemeGlobal),
              TTextXS(_project.plan!.operationalDefinition != null ? '"${_project.plan!.operationalDefinition!.trim()}"' : '-'),
            ],
          ),
        ),
      ],
    );
  }
}
