import 'package:flutter/material.dart';

import '../t_colors.dart';
import '../typography/t_text_large.dart';

class TopBar extends StatelessWidget {
  final String? title;
  final VoidCallback? backNavigationAction;

  const TopBar({this.title, this.backNavigationAction, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (backNavigationAction != null) _TopBarBackButton(onPressed: backNavigationAction!) else SizedBox.shrink(),
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
    return ElevatedButton(onPressed: onPressed, child: Text('Zurück'));
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
