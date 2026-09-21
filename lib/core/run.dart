// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_root.dart';
import 'life_cycle_cubit.dart';
import 'startup.dart';

void run(Startup startup) {
  WidgetsFlutterBinding.ensureInitialized();

  LifeCycleCubit cubit = LifeCycleCubit(startup);
  final container = startup.initBasicServices(overrides: [LifeCycleCubit.provider.overrideWith((ref) => cubit)]);
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: AppRoot(cubit: cubit),
    ),
  );
}
