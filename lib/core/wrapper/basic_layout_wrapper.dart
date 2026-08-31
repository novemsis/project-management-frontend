import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/bottom_bar.dart';
import '../components/top_bar.dart';
import '../cubit/basic_layout_cubit.dart';

class BasicLayoutWrapper extends ConsumerWidget {
  final Widget child;

  const BasicLayoutWrapper({required this.child, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double width = ref.read(BasicLayoutCubit.provider.bloc).getWidth();
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          TopBar(title: 'VisionFlow'),
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
          BottomBar(),
        ],
      ),
    );
  }
}
