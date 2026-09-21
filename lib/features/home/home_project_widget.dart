import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/t_colors.dart';
import '../../core/t_sizes.dart';
import '../../core/typography/t_text_normal.dart';
import '../../core/typography/t_text_small.dart';
import '../../core/widgets/t_divider.dart';
import '../../core/widgets/text_wrapper.dart';
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(TSpacings.p0),
                    margin: EdgeInsetsGeometry.only(right: TSpacings.p0),
                    decoration: BoxDecoration(
                      color: TColors.largeIconBackground,
                      borderRadius: BorderRadius.circular(TSpacings.p0),
                    ),
                    child: const Icon(
                      size: TSpacings.p3,
                      Icons.track_changes,
                      color: TColors.icon,
                    ),
                  ),
                  TTextNormal(
                    _project.title,
                    bold: true,
                  ),
                ],
              ),
              Icon(Icons.chevron_right),
            ],
          ),
          SizedBox(height: TSpacings.p1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TTextSmall('Ziel:'),
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
              TTextSmall('Plan:'),
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
              TTextSmall('Entschluss:'),
              if (_project.decision != null && _project.decision!.carryThrough)
                Icon(Icons.check, size: TIconSizes.small)
              else
                Icon(Icons.close, size: TIconSizes.small),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TTextSmall('Umsetzung:'),
              TTextSmall('${doneRatio}%'),
            ],
          ),
          if (_project.nextCheck != null) ...[
            TDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TTextSmall('Kontrolle:'),
                TextWrapper(
                  backgroundColor: TColors.errorLight,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: TSpacings.p0half),
                        child: Icon(
                          Icons.calendar_today_outlined,
                          size: TIconSizes.small,
                          color: TColors.error,
                        ),
                      ),
                      TTextSmall(
                        DateFormat('dd.MM.yyyy').format(_project.nextCheck!),
                        color: DateTime.now().isAfter(_project.nextCheck!) ? TColors.error : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
