import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart' hide HttpMethod;
import 'package:riverbloc/riverbloc.dart';

import '../core/api/api.dart';
import '../core/api/api_cubit.dart';
import '../core/api/api_states.dart';
import '../core/api/request_body.dart';
import 'account_state.dart';
import 'auth_token_store.dart';

class AccountCubit extends Cubit<AccountState> {
  static final BlocProvider<AccountCubit, AccountState> provider = BlocProvider<AccountCubit, AccountState>((ref) {
    final accountCubit = AccountCubit(
      apiCubit: ref.read(ApiCubit.provider.bloc),
      authTokenStore: ref.read(authTokenStoreProvider),
    );
    ref.onDispose(() => accountCubit.dispose());
    return accountCubit;
  });

  final ApiCubit _apiCubit;
  final AuthTokenStore _authTokenStore;

  AccountCubit({required this._apiCubit, required this._authTokenStore}) : super(AccountState.none()) {
    isLoggedIn();
    _apiCubit.stream.listen((state) {
      if (state == ApiStateTokenExpired) {
        clearAccountData();
      }
    });
  }

  void isLoggedIn() async {
    if (await _authTokenStore.authorizationHeader != null) {
      emit(AccountState.loggedIn());
    }
  }

  Future<bool> login(String username, String password) async {
    final Response<dynamic>? response = await _apiCubit.performCallToRoute(
      path: '/user/login',
      method: HttpMethod.post,
      body: LoginDto(username: username, password: password),
    );

    if (!(response?.isSuccessful ?? false) || response?.body == null) {
      return false;
    }

    final body = jsonDecode(response!.body.toString()) as Map<String, dynamic>;
    if (!body.containsKey('token') || !body.containsKey('expires_at') || DateTime.tryParse(body['expires_at'] as String) == null) {
      return false;
    }

    _authTokenStore.setToken(body['token'] as String, DateTime.tryParse(body['expires_at'] as String)!);
    emit(AccountState.loggedIn());

    return true;
  }

  void clearAccountData() {
    _authTokenStore.clear();
    emit(AccountState.none());
  }

  void dispose() {}
}

class LoginDto extends RequestBody {
  final String username;
  final String password;

  LoginDto({required this.username, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
