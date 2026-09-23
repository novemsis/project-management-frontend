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
    return switch (ref.watch(HomeCubit.provider)) {
      HomeStateSuccess(:final projects) => _getContent(projects),
      _ => SizedBox.shrink(),
    };
  }

  Widget _getContent(List<ProjectModel> projects) {
    return BasicLayoutWrapper(
      showTitleBar: false,
      title: null,
      child: Column(
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
          ListView.builder(
            padding: EdgeInsetsGeometry.all(0),
            shrinkWrap: true,
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return HomeProjectWidget(projects[index]);
            },
            physics: AlwaysScrollableScrollPhysics(),
          ),
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
      ),
    );
  }
}
