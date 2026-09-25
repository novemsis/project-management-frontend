import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/t_colors.dart';
import '../../core/t_sizes.dart';
import '../../core/typography/t_text_normal.dart';
import '../../core/typography/t_text_xs.dart';
import '../../core/widgets/t_divider.dart';
import '../../core/widgets/t_icon.dart';
import '../../core/widgets/text_wrapper.dart';
import '../../widgets/t_card.dart';
import '../project/project_model.dart';

class HomeProjectWidget extends StatelessWidget {
  final ProjectModel _project;

  const HomeProjectWidget(this._project, {super.key});

  @override
  Widget build(BuildContext context) {
    final doneRatio = _project.doneRatio != null ? double.parse(_project.doneRatio!).round() : null;
    final bool? checkDateIsOver = _project.nextCheck != null ? DateTime.now().isAfter(_project.nextCheck!) : null;
    return Column(
      children: [
        TCard(
          onTap: () => context.push('/project/${_project.id}'),
          child: Column(
            spacing: TSpacings.p0half,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(TSpacings.p0),
                        margin: EdgeInsetsGeometry.only(right: TSpacings.p0),
                        decoration: BoxDecoration(
                          color: TColors.schemeGlobalBackground,
                          borderRadius: BorderRadius.circular(TSpacings.p0),
                        ),
                        child: TIcon(Icons.track_changes),
                      ),
                      SizedBox(
                        width: 230,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TTextNormal(
                              _project.title,
                              bold: true,
                            ),
                            SizedBox(height: TSpacings.p0half),
                            TextWrapper(
                              backgroundColor: _project.isActive() ? TColors.successLight : TColors.inactiveLight,
                              child: TTextXS(
                                _project.isActive() ? 'Aktiv' : 'Inaktiv',
                                color: _project.isActive() ? TColors.success : TColors.inactive,
                                bold: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  TIcon(Icons.chevron_right),
                ],
              ),
              SizedBox(height: TSpacings.p1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TTextXS('Ziel:'),
                  if (_project.target != null && _project.target!.isSmarter)
                    SuccessIcon()
                  else if (_project.target != null)
                    WarningIcon()
                  else
                    TTextXS('-'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TTextXS('Plan:'),
                  if (_project.plan != null && _project.plan!.isDefined)
                    SuccessIcon()
                  else if (_project.plan != null)
                    WarningIcon()
                  else
                    TTextXS('-'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TTextXS('Entschluss:'),
                  if (_project.decision != null && _project.decision!.carryThrough) SuccessIcon() else TTextXS('-'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TTextXS('Umsetzung:'),
                  if (doneRatio != null) TTextXS('${doneRatio * 100}%') else TTextXS('-'),
                ],
              ),
              if (_project.nextCheck != null && checkDateIsOver != null) ...[
                TDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TTextXS('Kontrolle:'),
                    TextWrapper(
                      backgroundColor: checkDateIsOver ? TColors.errorLight : TColors.successLight,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: TSpacings.p0half),
                            child: TIcon(
                              Icons.calendar_today_outlined,
                              size: TIconSizes.xs,
                              color: checkDateIsOver ? TColors.error : TColors.success,
                            ),
                          ),
                          TTextXS(
                            DateFormat('dd.MM.yyyy').format(_project.nextCheck!),
                            color: checkDateIsOver ? TColors.error : TColors.success,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class IconWrapper extends StatelessWidget {
  final Color _color;
  final Widget _icon;

  IconWrapper({required this._icon, required this._color});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentGeometry.topStart,
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.circular(TSpacings.p1),
      ),
      padding: EdgeInsets.fromLTRB(TSpacings.p0half, TSpacings.p0half, TSpacings.p0half, TSpacings.p0half),
      child: _icon,
    );
  }
}

class SuccessIcon extends IconWrapper {
  SuccessIcon()
    : super(
        color: TColors.successLight,
        icon: TIcon(
          Icons.check,
          size: TIconSizes.xs,
          color: TColors.success,
        ),
      );
}

class WarningIcon extends IconWrapper {
  WarningIcon()
    : super(
        color: TColors.warningLight,
        icon: TIcon(
          Icons.warning_amber_rounded,
          size: TIconSizes.xs,
          color: TColors.warning,
        ),
      );
}
