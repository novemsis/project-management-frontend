import 'package:flutter/material.dart';

import '../../../core/t_colors.dart';
import '../../../core/t_sizes.dart';
import '../../../core/typography/t_text_normal_small.dart';
import '../../../core/typography/t_text_xs.dart';
import '../../../core/widgets/t_icon.dart';
import '../../../core/widgets/text_wrapper.dart';
import '../../../widgets/t_card.dart';
import '../project_model.dart';

class ProjectDetailsTargetPart extends StatelessWidget {
  final ProjectModel _project;

  const ProjectDetailsTargetPart(this._project, {super.key});

  @override
  Widget build(BuildContext context) {
    return TCard(
      child: Column(
        children: [
          Row(children: [TTextNormalSmall('Ziel')]),
          if (_project.target != null) ...[
            SizedBox(height: TSpacings.p0),
            ..._getExistingTargetContent(),
          ] else ...[
            InkWell(
              // ToDo: add target
              onTap: () => print('add Target'),
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
                      TIcon(Icons.add, size: TIconSizes.small),
                      SizedBox(width: TSpacings.p0),
                      TTextXS('Ziel hinzufügen', color: TColors.schemeGlobal),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: TSpacings.p0),
          ],
        ],
      ),
    );
  }

  List<Widget> _getExistingTargetContent() {
    final String definition = _project.target!.definition != null ? '"${_project.target!.definition!.trim()}"' : '-';
    return [
      Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TTextXS('Definition', color: TColors.schemeGlobal),
              TTextXS(definition),
            ],
          ),
        ],
      ),
      SizedBox(height: TSpacings.p0),
      Row(
        children: [
          _getSmarterCriteria('Spezifisch', _project.target!.isSmarterSpezifisch ?? false),
          SizedBox(width: TSpacings.p0half),
          _getSmarterCriteria('Messbar', _project.target!.isSmarterMessbar ?? false),
          SizedBox(width: TSpacings.p0half),
          _getSmarterCriteria('Ambitioniert', _project.target!.isSmarterAmbitioniert ?? false),
        ],
      ),
      SizedBox(height: TSpacings.p0),
      Row(
        children: [
          _getSmarterCriteria('Realistisch', _project.target!.isSmarterRealistisch ?? false),
          SizedBox(width: TSpacings.p0half),
          _getSmarterCriteria('Terminiert', _project.target!.isSmarterTerminiert ?? false),
        ],
      ),
      SizedBox(height: TSpacings.p0),
      Row(
        children: [
          _getSmarterCriteria('Emotionalisiert', _project.target!.isSmarterEmotionalisiert ?? false),
          SizedBox(width: TSpacings.p0half),
          _getSmarterCriteria('Ressourceneinsetzend', _project.target!.isSmarterRessourceneinsetzend ?? false),
        ],
      ),
    ];
  }

  Widget _getSmarterCriteria(String text, bool fulfilled) {
    return TextWrapper(
      child: Row(
        children: [
          TIcon(
            fulfilled ? Icons.check : Icons.close,
            size: TIconSizes.small,
            color: fulfilled ? TColors.schemeGlobal : TColors.inactive,
          ),
          SizedBox(width: TSpacings.p0quarter),
          TTextXS(
            text,
            color: fulfilled ? TColors.schemeGlobal : TColors.inactive,
            bold: true,
          ),
        ],
      ),
      backgroundColor: fulfilled ? TColors.schemeGlobalBackground : TColors.inactiveLight,
    );
  }
}
