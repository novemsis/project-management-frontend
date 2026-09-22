import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/t_colors.dart';
import '../../core/t_sizes.dart';
import '../../core/typography/t_text_normal_small.dart';
import '../../core/typography/t_text_xs.dart';
import '../../core/widgets/text_wrapper.dart';
import '../../core/wrapper/basic_layout_wrapper.dart';
import '../../widgets/t_card.dart';
import 'project_cubit.dart';
import 'project_model.dart';

class ProjectDetailsPage extends ConsumerWidget {
  final String _projectId;

  const ProjectDetailsPage(this._projectId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BasicLayoutWrapper(
      title: null,
      child: switch (ref.watch(ProjectCubit.provider(_projectId))) {
        ProjectStateSuccess(:final project) => _getContent(context, project),
        _ => SizedBox.shrink(),
      },
    );
  }

  Widget _getContent(BuildContext context, ProjectModel project) {
    return Column(
      children: [
        TCard(
          child: Row(
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
                    child: const Icon(
                      size: TSpacings.p4,
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
                      if (project.isActive()) ...[
                        SizedBox(
                          height: TSpacings.p0half,
                        ),
                        TextWrapper(
                          backgroundColor: TColors.successLight,
                          child: TTextXS(
                            'Aktiv',
                            color: TColors.success,
                            bold: true,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
              InkWell(
                borderRadius: BorderRadius.circular(TSpacings.p1),
                onTap: () => print('edit'),
                child: TextWrapper(
                  backgroundColor: TColors.schemeGlobalBackground,
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit_outlined,
                        size: TSpacings.p1,
                        color: TColors.schemeGlobal,
                      ),
                      SizedBox(width: TSpacings.p0half),
                      TTextXS('Bearbeiten', color: TColors.schemeGlobal),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
