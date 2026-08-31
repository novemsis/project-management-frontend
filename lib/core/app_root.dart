import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../home/home_page.dart';
import 'cubit/basic_layout_cubit.dart';
import 'life_cycle_cubit.dart';

class AppRoot extends ConsumerStatefulWidget {
  final LifeCycleCubit cubit;

  const AppRoot({required this.cubit, super.key});

  @override
  ConsumerState<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends ConsumerState<AppRoot> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    ref.read(BasicLayoutCubit.provider.bloc).initialize(deviceWidth: deviceWidth, deviceHeight: deviceHeight);

    return MaterialApp(
      title: 'VisionFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(),
    );
  }

  @override
  void dispose() {
    widget.cubit.close();
    super.dispose();
  }
}
