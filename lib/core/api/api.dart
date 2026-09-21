import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:http/io_client.dart';
import 'package:riverpod/riverpod.dart';

import '../../account/auth_token_store.dart';
import '../app_config.dart';
import 'authorization_header_interceptor.dart';

const _clientName = 'VisionFlow';

final authenticatedApiProvider = Provider((ref) {
  final backendApi = ChopperClient(
    baseUrl: ref.read(AppConfig.provider).apiUri,
    client: ref.watch(httpClientProvider),
    interceptors: [
      AuthorizationHeaderInterceptor(
        getAuthorizationHeader: () => ref.read(authTokenStoreProvider).authorizationHeader,
      ),
    ],
  );
  ref.onDispose(() => backendApi.dispose());
  return backendApi;
});

final unauthenticatedApiProvider = Provider((ref) {
  final backendApi = ChopperClient(
    baseUrl: ref.read(AppConfig.provider).apiUri,
    client: ref.watch(httpClientProvider),
  );
  ref.onDispose(() => backendApi.dispose());
  return backendApi;
});

final httpClientProvider = Provider((ref) {
  final httpClient = IOClient(
    HttpClient(context: SecurityContext.defaultContext..allowLegacyUnsafeRenegotiation = false)
      ..connectionTimeout = const Duration(seconds: 30)
      ..userAgent = '$_clientName',
  );
  ref.onDispose(() => httpClient.close());
  return httpClient;
});

enum HttpMethod {
  get,
  post,
  put,
  patch,
  delete,
}

extension HttpMethodExtension on HttpMethod {
  String get value => switch (this) {
    HttpMethod.get => 'GET',
    HttpMethod.post => 'POST',
    HttpMethod.put => 'PUT',
    HttpMethod.patch => 'PATCH',
    HttpMethod.delete => 'DELETE',
  };
}
