import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../cubit/basic_layout_cubit.dart';
import '../t_colors.dart';
import '../t_sizes.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/top_bar.dart';

class BasicLayoutWrapper extends ConsumerWidget {
  final Widget child;
  final bool _showTitle;
  final bool _showTitleBar;
  final bool _showBottomBar;

  const BasicLayoutWrapper({
    required this.child,
    this._showTitle = true,
    this._showTitleBar = true,
    this._showBottomBar = true,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double width = ref.read(BasicLayoutCubit.provider.bloc).getWidth();
    return Material(
      color: TColors.backgroundGlobal,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            if (_showTitleBar)
              Padding(
                padding: const EdgeInsets.only(bottom: TSpacings.p1),
                child: TopBar(title: _showTitle ? 'VisionFlow' : null),
              ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Center(
                  child: SizedBox(
                    width: width,
                    child: child,
                  ),
                ),
              ),
            ),
            if (_showBottomBar) BottomBar(),
          ],
        ),
      ),
    );
  }
}
