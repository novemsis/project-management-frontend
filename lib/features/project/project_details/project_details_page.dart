import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/t_sizes.dart';
import '../../../core/t_snackbar.dart';
import '../../../core/wrapper/basic_layout_wrapper.dart';
import '../project_model.dart';
import 'project_details_cubit.dart';
import 'project_details_general_part.dart';
import 'project_details_progress_part.dart';

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
        ProjectDetailsGeneralPart(project),
        SizedBox(height: TSpacings.p0),
        ProjectDetailsProgressPart(project),
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
}
