import 'package:flutter/material.dart';

import '../t_colors.dart';
import '../t_sizes.dart';
import '../typography/t_text_large.dart';

class TopBar extends StatelessWidget {
  final String? title;
  final VoidCallback? backNavigationAction;

  const TopBar({this.title, this.backNavigationAction, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (backNavigationAction != null) _TopBarBackButton(onPressed: backNavigationAction!) else SizedBox.shrink(),
        SizedBox(width: TSpacings.p8),
        if (title != null) _TopBarTitle(title!),
        SizedBox.shrink(),
      ],
    );
  }
}

class _TopBarBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _TopBarBackButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(TSpacings.p2),
      onTap: onPressed,
      child: Container(
        padding: EdgeInsetsGeometry.all(TSpacings.p0half),
        decoration: BoxDecoration(
          color: TColors.schemeGlobalBackground,
          borderRadius: BorderRadius.circular(TSpacings.p2),
        ),
        child: Icon(
          Icons.arrow_back_ios_new,
          size: TSpacings.p1,
        ),
      ),
    );
  }
}

class _TopBarTitle extends StatelessWidget {
  final String title;

  const _TopBarTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return TTextLarge(
      title,
      color: TColors.title,
    );
  }
}
