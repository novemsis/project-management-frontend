import 'package:riverbloc/riverbloc.dart';

import '../bloc_safe_emit.dart';

sealed class BasicLayoutState {
  const BasicLayoutState();

  factory BasicLayoutState.initial() = BasicLayoutStateInitial;
}

final class BasicLayoutStateInitial extends BasicLayoutState {
  const BasicLayoutStateInitial();
}

class BasicLayoutCubit extends Cubit<BasicLayoutState> with BlocSafeEmit {
  static final BlocProvider<BasicLayoutCubit, BasicLayoutState> provider = BlocProvider<BasicLayoutCubit, BasicLayoutState>(
    (ref) => BasicLayoutCubit(),
  );

  final double _widthFactor = 0.9;
  final double _heightFactor = 1;
  double? _deviceWidth;
  double? _deviceHeight;

  BasicLayoutCubit() : super(BasicLayoutState.initial());

  void initialize({required double deviceWidth, required double deviceHeight}) {
    this._deviceWidth = deviceWidth;
    this._deviceHeight = deviceHeight;
  }

  double getWidth() {
    if (_deviceWidth == null) {
      throw Exception('uninitialized App');
    }

    return _deviceWidth! * _widthFactor;
  }

  double getHeight() {
    if (_deviceHeight == null) {
      throw Exception('uninitialized App');
    }

    return _deviceHeight! * _heightFactor;
  }
}
