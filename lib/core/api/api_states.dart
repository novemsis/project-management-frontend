sealed class ApiState {
  const ApiState();

  factory ApiState.initial() = ApiStateInitial;

  factory ApiState.loading() = ApiStateLoading;

  factory ApiState.success() = ApiStateSuccess;

  factory ApiState.error() = ApiStateError;

  factory ApiState.tokenExpired() = ApiStateTokenExpired;
}

final class ApiStateInitial extends ApiState {
  const ApiStateInitial();
}

final class ApiStateLoading extends ApiState {
  const ApiStateLoading();
}

final class ApiStateSuccess extends ApiState {
  const ApiStateSuccess();
}

final class ApiStateError extends ApiState {
  const ApiStateError();
}

final class ApiStateTokenExpired extends ApiState {
  const ApiStateTokenExpired();
}
