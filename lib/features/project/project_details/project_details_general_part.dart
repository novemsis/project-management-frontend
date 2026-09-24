import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/t_colors.dart';
import '../../../core/t_sizes.dart';
import '../../../core/typography/t_text_normal_small.dart';
import '../../../core/typography/t_text_xs.dart';
import '../../../core/widgets/t_icon.dart';
import '../../../core/widgets/text_wrapper.dart';
import '../../../widgets/t_card.dart';
import '../project_model.dart';

class ProjectDetailsGeneralPart extends StatelessWidget {
  final ProjectModel _project;

  const ProjectDetailsGeneralPart(this._project, {super.key});

  @override
  Widget build(BuildContext context) {
    return TCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(TSpacings.p0),
                    decoration: BoxDecoration(
                      color: TColors.schemeGlobalBackground,
                      borderRadius: BorderRadius.circular(TSpacings.p0),
                    ),
                    child: const TIcon(
                      size: TIconSizes.large,
                      Icons.track_changes,
                      color: TColors.schemeGlobal,
                    ),
                  ),
                  SizedBox(width: TSpacings.p1),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TTextXS('Projekt', bold: true, color: TColors.schemeGlobal),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 140),
                        child: TTextNormalSmall(
                          _project.title,
                          bold: true,
                        ),
                      ),
                      SizedBox(height: TSpacings.p0half),
                      TextWrapper(
                        backgroundColor: _project.isActive() ? TColors.successLight : TColors.inactiveLight,
                        child: TTextXS(
                          _project.isActive() ? 'Aktiv' : 'Inaktiv',
                          color: _project.isActive() ? TColors.success : TColors.inactive,
                          bold: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              InkWell(
                borderRadius: BorderRadius.circular(TSpacings.p1),
                // ToDo: edit project
                onTap: () => print('edit'),
                child: TextWrapper(
                  backgroundColor: TColors.schemeGlobalBackground,
                  child: Row(
                    children: [
                      TIcon(
                        Icons.edit_outlined,
                        size: TIconSizes.small,
                      ),
                      SizedBox(width: TSpacings.p0half),
                      TTextXS('Bearbeiten', color: TColors.schemeGlobal),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: TSpacings.p0),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(TSpacings.p8, 0, TSpacings.p0half, 0),
                child: TIcon(
                  Icons.calendar_today_outlined,
                  size: TIconSizes.small,
                  color: TColors.textSecondary,
                ),
              ),
              TTextXS(
                _getProjectRange(_project),
                color: TColors.textSecondary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getProjectRange(ProjectModel project) {
    final DateTime? start = project.projectStart;
    final DateTime? end = project.projectEnd;
    if (start != null && end != null) {
      return DateFormat('dd.MM.yyyy').format(start) + ' - ' + DateFormat('dd.MM.yyyy').format(end);
    } else {
      return '-';
    }
  }
}
