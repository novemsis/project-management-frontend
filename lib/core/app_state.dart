// coverage:ignore-file

sealed class AppState {
  const AppState();

  factory AppState.stopped() = AppStateStopped;
  factory AppState.firstBooting() = AppStateFirstBooting;
  factory AppState.running() = AppStateRunning;
  factory AppState.inactive() = AppStateInactive;
  factory AppState.paused() = AppStatePaused;
  factory AppState.restarting() = AppStateRestarting;
}

final class AppStateStopped extends AppState {
  const AppStateStopped();
}

final class AppStateFirstBooting extends AppState {
  const AppStateFirstBooting();
}

final class AppStateRunning extends AppState {
  const AppStateRunning();
}

final class AppStateInactive extends AppState {
  const AppStateInactive();
}

final class AppStatePaused extends AppState {
  const AppStatePaused();
}

final class AppStateRestarting extends AppState {
  const AppStateRestarting();
}