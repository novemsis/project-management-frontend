import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:riverpod/riverpod.dart';

import '../account/account_cubit.dart';
import 'app_config.dart';
import 'app_state.dart';
import 'bloc_safe_emit.dart';
import 'startup.dart';

class LifeCycleCubit extends Cubit<AppState> with BlocSafeEmit {
  static final provider = Provider<LifeCycleCubit>((ref) {
    throw Exception('Should be provided using override');
  });

  ProviderContainer? _container;

  final Startup _startup;

  LifeCycleCubit(Startup startup) : _startup = startup, super(AppState.stopped());

  AppConfig getConfig() {
    return _startup.appConfig;
  }

  Future<void> handleLifeCycleEvent(AppLifecycleState event) async {
    switch (state) {
      case AppStateStopped():
        if (event == AppLifecycleState.resumed) {}
      case AppStateFirstBooting():
      case AppStateRunning():
      case AppStateInactive():
      case AppStatePaused():
      case AppStateRestarting():
    }
  }

  void startApp() {
    _container?.dispose();
    _container = _startup.initBasicServices(overrides: [LifeCycleCubit.provider.overrideWith((ref) => this)]);
    final AccountCubit? accountCubit = _container!.read(AccountCubit.provider.bloc);
  }
}
