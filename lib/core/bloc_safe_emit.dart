import 'package:bloc/bloc.dart';

mixin BlocSafeEmit<State> on BlocBase<State> {
  @override
  void emit(State state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}