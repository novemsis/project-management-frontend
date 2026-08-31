import 'package:bloc/bloc.dart';
import 'package:project_management_frontend/core/app_config.dart';
import 'package:project_management_frontend/core/bloc_safe_emit.dart';
import 'package:project_management_frontend/core/startup.dart';
import 'package:riverpod/riverpod.dart';

import 'app_state.dart';

class LifeCycleCubit extends Cubit<AppState> with BlocSafeEmit {
  static final provider = Provider<LifeCycleCubit>((ref) {
    throw Exception('Should be provided using override');
  });

  final Startup _startup;

  LifeCycleCubit(Startup startup): _startup = startup, super(AppState.stopped());

  AppConfig getConfig() {
    return _startup.appConfig;
  }
}