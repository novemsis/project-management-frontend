import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/t_colors.dart';
import '../../../core/t_sizes.dart';
import '../../../core/t_snackbar.dart';
import '../../../core/typography/t_text_normal_small.dart';
import '../../../core/typography/t_text_xs.dart';
import '../../../core/widgets/t_icon.dart';
import '../../../core/widgets/text_wrapper.dart';
import '../../../core/wrapper/basic_layout_wrapper.dart';
import '../../../widgets/t_card.dart';
import '../project_model.dart';
import 'project_details_cubit.dart';

class ProjectDetailsPage extends ConsumerWidget {
  final String _projectId;

  const ProjectDetailsPage(this._projectId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _registerListeners(context, ref);
    return BasicLayoutWrapper(
      backNavigationAction: context.pop,
      refreshAction: ref.read(ProjectDetailsCubit.provider(_projectId).bloc).loadProject,
      child: switch (ref.watch(ProjectDetailsCubit.provider(_projectId))) {
        ProjectDetailsStateSuccess(:final project) => _getContent(context, project),
        _ => SizedBox.shrink(),
      },
    );
  }

  Widget _getContent(BuildContext context, ProjectModel project) {
    return Column(
      children: [
        TCard(
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
                          TTextNormalSmall(
                            project.title,
                            bold: true,
                          ),
                          SizedBox(height: TSpacings.p0half),
                          TextWrapper(
                            backgroundColor: project.isActive() ? TColors.successLight : TColors.inactiveLight,
                            child: TTextXS(
                              project.isActive() ? 'Aktiv' : 'Inaktiv',
                              color: project.isActive() ? TColors.success : TColors.inactive,
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
                    _getProjectRange(project),
                    color: TColors.textSecondary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _registerListeners(BuildContext context, WidgetRef ref) {
    ref.listen(ProjectDetailsCubit.provider(_projectId), (prev, next) {
      if (next is ProjectDetailsStateError) {
        TSnackBar.error(context, 'Error while loading Project Details');
        context.go('/');
      }
    });
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
