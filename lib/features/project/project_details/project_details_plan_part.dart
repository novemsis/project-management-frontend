import 'package:flutter/material.dart';

import '../../../core/t_colors.dart';
import '../../../core/t_sizes.dart';
import '../../../core/typography/t_text_small.dart';
import '../../../core/typography/t_text_xxs.dart';
import '../../../core/widgets/t_icon.dart';
import '../../../widgets/t_card.dart';
import '../project_model.dart';

class ProjectDetailsPlanPart extends StatelessWidget {
  final ProjectModel _project;

  const ProjectDetailsPlanPart(this._project, {super.key});

  @override
  Widget build(BuildContext context) {
    return TCard(
      // ToDo: implement plan dialog (only if plan exists)
      onTap: () => print('open plan dialog'),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TTextSmall('Plan'),
              if (_project.plan != null)
                TIcon(
                  Icons.chevron_right,
                  color: TColors.textPrimary,
                  size: TIconSizes.small,
                ),
            ],
          ),
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
                      TIcon(Icons.add, size: TIconSizes.xs),
                      SizedBox(width: TSpacings.p0),
                      TTextXXS('Plan hinzufügen', color: TColors.schemeGlobal),
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
              TTextXXS('Strategische Definition', color: TColors.schemeGlobal),
              TTextXXS(_project.plan!.strategicDefinition != null ? '"${_project.plan!.strategicDefinition!.trim()}"' : '-'),
              SizedBox(height: TSpacings.p0),
              TTextXXS('Taktische Definition', color: TColors.schemeGlobal),
              TTextXXS(_project.plan!.tacticalDefinition != null ? '"${_project.plan!.tacticalDefinition!.trim()}"' : '-'),
              SizedBox(height: TSpacings.p0),
              TTextXXS('Operative Definition', color: TColors.schemeGlobal),
              TTextXXS(_project.plan!.operationalDefinition != null ? '"${_project.plan!.operationalDefinition!.trim()}"' : '-'),
            ],
          ),
        ),
      ],
    );
  }
}
