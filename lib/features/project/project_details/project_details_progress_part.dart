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
    final donePercentage = _project.doneRatio != null ? double.parse(_project.doneRatio!).round() * 100 : 0;

    final bool isSmarter = _project.target?.isSmarter ?? false;
    final bool isPlanned = isSmarter && (_project.plan?.isDefined ?? false);
    final bool isDecided = isSmarter && isPlanned && (_project.decision?.carryThrough ?? false);
    final bool isTodoDone = isSmarter && isPlanned && isDecided && (!_project.toDos.any((toDo) => !toDo.isDone));
    final bool isChecked = isSmarter && isPlanned && isDecided && isTodoDone && donePercentage == 100;

    return TCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TTextNormalSmall('Projektfortschritt'),
              TextWrapper(
                child: TTextXS('${donePercentage}%', color: TColors.inactive),
                backgroundColor: TColors.inactiveLight,
              ),
            ],
          ),
          SizedBox(height: TSpacings.p0),
          Row(
            children: [
              Column(
                children: [
                  _getProgressIcon(Icons.check, isSmarter),
                  SizedBox(height: TSpacings.p0half),
                  TTextXS('Ziel'),
                ],
              ),
              _getConnectingLine(
                color: isPlanned ? TColors.schemeGlobal : TColors.inactiveLight,
                indent: TSpacings.p0half,
                endIndent: TSpacings.p0half,
              ),
              Column(
                children: [
                  _getProgressIcon(Icons.psychology, isPlanned),
                  SizedBox(height: TSpacings.p0half),
                  TTextXS('Plan'),
                ],
              ),
              _getConnectingLine(color: isDecided ? TColors.schemeGlobal : TColors.inactiveLight, indent: TSpacings.p0half),
              Column(
                children: [
                  _getProgressIcon(Icons.crisis_alert, isDecided),
                  SizedBox(height: TSpacings.p0half),
                  TTextXS('Entsch.'),
                ],
              ),
              _getConnectingLine(color: isTodoDone ? TColors.schemeGlobal : TColors.inactiveLight),
              Column(
                children: [
                  _getProgressIcon(Icons.checklist, isTodoDone),
                  SizedBox(height: TSpacings.p0half),
                  TTextXS('ToDos'),
                ],
              ),
              _getConnectingLine(color: isChecked ? TColors.schemeGlobal : TColors.inactiveLight),
              Column(
                children: [
                  _getProgressIcon(Icons.event_repeat, isChecked),
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

  Widget _getProgressIcon(IconData icon, bool isFulfilled) {
    return Container(
      decoration: BoxDecoration(
        color: isFulfilled ? TColors.schemeGlobal : TColors.inactiveLight,
        borderRadius: BorderRadius.circular(TSpacings.p1),
      ),
      padding: EdgeInsets.fromLTRB(TSpacings.p0half, TSpacings.p0half, TSpacings.p0half, TSpacings.p0half),
      child: TIcon(
        icon,
        size: TIconSizes.small,
        color: isFulfilled ? TColors.textWhite : TColors.inactiveLight,
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
