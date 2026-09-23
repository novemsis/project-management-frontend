import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/t_colors.dart';
import '../../core/t_sizes.dart';
import '../../core/typography/t_text_large.dart';
import '../../core/typography/t_text_small.dart';
import '../../core/widgets/t_icon.dart';
import '../../core/wrapper/basic_layout_wrapper.dart';
import '../project/project_model.dart';
import 'home_cubit.dart';
import 'home_project_widget.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BasicLayoutWrapper(
      showTitleBar: false,
      title: null,
      refreshAction: ref.read(HomeCubit.provider.bloc).loadProjects,
      child: switch (ref.watch(HomeCubit.provider)) {
        HomeStateSuccess(:final projects) => _getContent(projects, ref),
        _ => SizedBox.shrink(),
      },
    );
  }

  Widget _getContent(List<ProjectModel> projects, WidgetRef ref) {
    return Column(
      children: [
        Row(
          children: [
            TTextLarge(
              'Deine Projekte',
              bold: true,
            ),
          ],
        ),
        SizedBox(height: TSpacings.p0),
        Row(
          children: [
            Container(
              width: 250,
              child: TTextSmall(
                'Hier findest du eine Übersicht über all deine VisionFlow Projekte',
              ),
            ),
          ],
        ),
        SizedBox(height: TSpacings.p1),
        ...projects.map((project) => HomeProjectWidget(project)),
        Padding(
          padding: const EdgeInsets.only(bottom: TSpacings.p0),
          child: IconButton(
            // ToDo: add new Project
            onPressed: () => print('pressed on add new Project'),
            icon: TIcon(Icons.add_circle_outline, color: TColors.textPrimary),
            iconSize: TIconSizes.normal,
          ),
        ),
      ],
    );
  }
}
