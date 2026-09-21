import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'cubit/basic_layout_cubit.dart';
import 'life_cycle_cubit.dart';
import 'routing/app_router.dart';
import 't_colors.dart';

class AppRoot extends ConsumerStatefulWidget {
  final LifeCycleCubit cubit;

  const AppRoot({required this.cubit, super.key});

  @override
  ConsumerState<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends ConsumerState<AppRoot> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    ref.read(BasicLayoutCubit.provider.bloc).initialize(deviceWidth: deviceWidth, deviceHeight: deviceHeight);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp.router(
        title: 'VisionFlow',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: .fromSeed(seedColor: TColors.schemeGlobal),
        ),
        routerConfig: ref.watch(appRouterProvider),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    widget.cubit.handleLifeCycleEvent(state);
  }

  @override
  void dispose() {
    widget.cubit.close();
    super.dispose();
  }
}
