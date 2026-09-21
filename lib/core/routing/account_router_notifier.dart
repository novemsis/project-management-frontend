import 'dart:async';

import 'package:flutter/material.dart';

import '../../account/account_cubit.dart';
import '../../account/account_state.dart';

class AccountRouterNotifier extends ChangeNotifier {
  late final StreamSubscription<AccountState> _subscription;

  AccountRouterNotifier(AccountCubit accountCubit) {
    _subscription = accountCubit.stream.listen((_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
