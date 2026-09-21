import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/t_colors.dart';
import '../../core/t_sizes.dart';
import '../../core/typography/t_text_normal.dart';
import '../../widgets/t_card.dart';
import '../project/project_model.dart';

class HomeProjectWidget extends StatelessWidget {
  final ProjectModel _project;

  const HomeProjectWidget(this._project, {super.key});

  @override
  Widget build(BuildContext context) {
    final doneRatio = _project.doneRatio != null ? double.parse(_project.doneRatio!).round() : null;
    return TCard(
      onTap: () => context.push('/project/${_project.id}'),
      child: Column(
        spacing: TSpacings.p0half,
        children: [
          TTextNormal(
            _project.title,
            bold: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TTextNormal('Ziel:'),
              if (_project.target != null && _project.target!.isSmarter)
                Icon(Icons.check, size: TIconSizes.small)
              else if (_project.target != null)
                Icon(Icons.warning_amber_rounded, size: TIconSizes.small)
              else
                Icon(Icons.close, size: TIconSizes.small),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TTextNormal('Plan:'),
              if (_project.plan != null && _project.plan!.isDefined)
                Icon(Icons.check, size: TIconSizes.small)
              else if (_project.plan != null)
                Icon(Icons.warning_amber_rounded, size: TIconSizes.small)
              else
                Icon(Icons.close, size: TIconSizes.small),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TTextNormal('Entschluss:'),
              if (_project.decision != null && _project.decision!.carryThrough)
                Icon(Icons.check, size: TIconSizes.small)
              else
                Icon(Icons.close, size: TIconSizes.small),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TTextNormal('Umsetzung:'),
              TTextNormal('${doneRatio}%'),
            ],
          ),
          if (_project.nextCheck != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TTextNormal('Kontrolle:'),
                TTextNormal(
                  DateFormat('dd.MM.yyyy').format(_project.nextCheck!),
                  color: DateTime.now().isAfter(_project.nextCheck!) ? TColors.attention : null,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
