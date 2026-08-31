import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/t_colors.dart';
import '../core/t_sizes.dart';
import '../core/wrapper/basic_layout_wrapper.dart';
import 'home_project_widget.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ColoredBox(
      color: TColors.backgroundGlobal,
      child: BasicLayoutWrapper(
        child: Column(
          children: [
            HomeProjectWidget(),
            HomeProjectWidget(),
            HomeProjectWidget(),
            HomeProjectWidget(),
            HomeProjectWidget(),
            HomeProjectWidget(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, TSpacings.p0),
              child: IconButton(
                // ToDo: implement functionality for adding new Project
                onPressed: () => print('pressed on add new Project'),
                icon: Icon(Icons.add_circle_outline),
                iconSize: TIconSizes.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
