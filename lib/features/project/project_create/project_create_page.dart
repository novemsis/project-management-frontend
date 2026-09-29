import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/t_snackbar.dart';
import '../../../core/typography/t_text_small.dart';
import '../../../core/wrapper/basic_layout_wrapper.dart';
import 'project_create_cubit.dart';

class ProjectCreatePage extends ConsumerWidget {
  const ProjectCreatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _registerListeners(context, ref);
    return BasicLayoutWrapper(
      backNavigationAction: context.pop,
      child: TTextSmall('hi'),
    );
  }

  void _registerListeners(BuildContext context, WidgetRef ref) {
    ref.listen(ProjectCreateCubit.provider, (prev, next) {
      if (next is ProjectCreateStateError) {
        TSnackBar.error(context, 'Error while saving Project');
        context.go('/');
      }

      if (next is ProjectCreateStateSuccess) {
        TSnackBar.success(context, 'Successfully saved Project');
      }
    });
  }
}
