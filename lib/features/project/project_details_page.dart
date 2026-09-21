import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/typography/t_text_large.dart';
import '../../core/typography/t_text_normal.dart';
import '../../core/wrapper/basic_layout_wrapper.dart';
import '../../widgets/t_card.dart';
import 'project_cubit.dart';
import 'project_model.dart';

class ProjectDetailsPage extends ConsumerWidget {
  final String _projectId;

  const ProjectDetailsPage(this._projectId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (ref.watch(ProjectCubit.provider(_projectId))) {
      ProjectStateSuccess(:final project) => _getContent(context, project),
      _ => SizedBox.shrink(),
    };
  }

  Widget _getContent(BuildContext context, ProjectModel project) {
    return BasicLayoutWrapper(
      child: Column(
        children: [
          Center(
            child: TTextLarge(project.title),
          ),
          TCard(
            child: TTextNormal('Project ID: ${_projectId}'),
          ),
        ],
      ),
    );
  }
}
