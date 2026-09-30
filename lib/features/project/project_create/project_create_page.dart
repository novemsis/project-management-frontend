import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/t_colors.dart';
import '../../../core/t_sizes.dart';
import '../../../core/t_snackbar.dart';
import '../../../core/typography/t_text_large.dart';
import '../../../core/typography/t_text_normal.dart';
import '../../../core/wrapper/basic_layout_wrapper.dart';
import '../../widgets/t_card.dart';
import '../../widgets/t_icon.dart';
import '../../widgets/t_text_field.dart';
import 'project_create_cubit.dart';

class ProjectCreatePage extends ConsumerWidget {
  const ProjectCreatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _registerListeners(context, ref);
    final formKey = GlobalKey<FormState>();
    return BasicLayoutWrapper(
      backNavigationAction: context.pop,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: AlignmentGeometry.topStart,
                decoration: BoxDecoration(
                  color: TColors.schemeGlobalBackground,
                  borderRadius: BorderRadius.circular(TSpacings.p6),
                ),
                padding: EdgeInsets.all(TSpacings.p2),
                child: TIcon(Icons.add, size: TIconSizes.xxl),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(TSpacings.p1),
            child: TTextLarge('Neues Projekt', bold: true),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: TSpacings.p1),
            child: TTextNormal(
              'Starte dein neues Projekt und bringe deine Visionen Schritt für Schritt auf den Weg',
              textOverflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              color: TColors.textSecondary,
            ),
          ),
          SizedBox(height: TSpacings.p2),
          Form(
            key: formKey,
            child: Column(
              children: [
                TCard(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(TSpacings.p0),
                        child: TIcon(Icons.title),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 300),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                TTextNormal('Titel'),
                                SizedBox(width: TSpacings.p0half),
                                TTextNormal('*', bold: true, color: TColors.error),
                              ],
                            ),
                            TTextfield(
                              labelText: 'z.B. App-Entwicklung, Marketing-Kampagne',
                              maxLength: 255,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: TSpacings.p0),
                TCard(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(TSpacings.p0),
                        child: TIcon(Icons.text_snippet),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 300),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TTextNormal('Beschreibung'),
                            TTextfield(
                              labelText: 'Beschreibe dein Projekt kurz...',
                              maxLines: 5,
                              minLines: 1,
                              maxLength: 1000,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: TSpacings.p2),
          InkWell(
            onTap: () => _createProject(context, ref, formKey),
            child: Container(
              alignment: AlignmentGeometry.center,
              decoration: BoxDecoration(
                color: TColors.schemeGlobal,
                borderRadius: BorderRadius.circular(TSpacings.p1),
              ),
              padding: EdgeInsets.all(TSpacings.p1half),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  TTextNormal('Projekt erstellen', color: TColors.elevatedButtonText),
                  SizedBox(width: TSpacings.p0),
                  TIcon(Icons.arrow_forward, color: TColors.elevatedButtonText, size: TIconSizes.small),
                ],
              ),
            ),
          ),
        ],
      ),
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

  void _createProject(BuildContext context, WidgetRef ref, GlobalKey<FormState> formKey) async {
    final String? title = formKey.currentState?.fields.first.value as String?;
    final String? description = formKey.currentState?.fields.elementAt(1).value as String?;

    if (title != null) {
      String? projectId = await ref.read(ProjectCreateCubit.provider.bloc).createProject(title, description);
      if (projectId != null) {
        context.pop();
        await context.push('/project/${projectId}');
      }
    }
  }
}
