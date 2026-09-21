import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../routing/app_router.dart';
import '../t_colors.dart';
import '../t_sizes.dart';

class BottomBar extends ConsumerWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ColoredBox(
      color: TColors.bottomBar,
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(child: SizedBox.shrink()),
            Expanded(
              child: IconButton(
                iconSize: TIconSizes.normal,
                padding: EdgeInsetsGeometry.all(0),
                icon: Icon(Icons.home_outlined, color: TColors.textGlobal),
                onPressed: () => ref.read(appRouterProvider).go('/'),
              ),
            ),
            Expanded(child: SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}
