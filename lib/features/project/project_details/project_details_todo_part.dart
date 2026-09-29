import 'dart:math';

import 'package:flutter/material.dart';

import '../../../core/t_colors.dart';
import '../../../core/t_sizes.dart';
import '../../../core/typography/t_text_small.dart';
import '../../../core/typography/t_text_xs.dart';
import '../../../core/typography/t_text_xxs.dart';
import '../../../core/widgets/t_checkbox.dart';
import '../../../core/widgets/t_icon.dart';
import '../../../core/widgets/text_wrapper.dart';
import '../../../widgets/t_card.dart';
import '../project_model.dart';

class ProjectDetailsTodoPart extends StatelessWidget {
  final ProjectModel _project;

  const ProjectDetailsTodoPart(this._project, {super.key});

  @override
  Widget build(BuildContext context) {
    int todosDone = 0;
    if (_project.toDos.isNotEmpty) {
      todosDone = _project.toDos.where((todo) => todo.isDone).length;
    }
    return TCard(
      // ToDo: implement todo dialog (only if ToDos exist)
      onTap: () => print('open ToDo dialog'),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TTextSmall('ToDos'),
              if (_project.toDos.isNotEmpty)
                Row(
                  children: [
                    TextWrapper(
                      child: TTextXXS('${todosDone}/${_project.toDos.length}', color: TColors.schemeGlobal, bold: true),
                      backgroundColor: TColors.schemeGlobalBackground,
                    ),
                    SizedBox(width: TSpacings.p0),
                    TIcon(
                      Icons.chevron_right,
                      color: TColors.textPrimary,
                      size: TIconSizes.small,
                    ),
                  ],
                ),
            ],
          ),
          if (_project.toDos.isNotEmpty) ...[
            SizedBox(height: TSpacings.p0),
            ..._getExistingToDoContent(),
          ],
          InkWell(
            // ToDo: add ToDo
            onTap: () => print('add ToDo'),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(TSpacings.p1),
                border: BoxBorder.all(color: TColors.schemeGlobal),
              ),
              child: Padding(
                padding: const EdgeInsets.all(TSpacings.p0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TIcon(Icons.add, size: TIconSizes.xs),
                    SizedBox(width: TSpacings.p0),
                    TTextXXS('add ToDo', color: TColors.schemeGlobal),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: TSpacings.p0),
        ],
      ),
    );
  }

  List<Widget> _getExistingToDoContent() {
    List<Widget> toDos = [];
    for (int i = 0; i < min(_project.toDos.length, 5); i++) {
      final toDo = _project.toDos.elementAt(i);
      toDos.add(
        TCheckbox(
          //ToDo: save ToDo state change
          onChanged: (value) => print('save todo change'),
          isActive: toDo.isDone,
          text: TTextXS(
            toDo.description,
            color: TColors.textPrimary,
          ),
        ),
      );
    }
    return [...toDos];
  }
}
