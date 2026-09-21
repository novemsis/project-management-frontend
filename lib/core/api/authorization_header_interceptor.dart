import 'dart:async';

import 'package:chopper/chopper.dart';

class NoTokenException implements Exception {
  @override
  String toString() => 'NoTokenException: no authorization token available';
}

typedef GetAuthorizationHeaderCb = Future<String?> Function();
typedef GetAuthorizationHeaderExpirationCb = Future<DateTime?> Function();

class AuthorizationHeaderInterceptor implements Interceptor {
  final GetAuthorizationHeaderCb getAuthorizationHeader;

  AuthorizationHeaderInterceptor({required this.getAuthorizationHeader});

  @override
  Future<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async {
    final header = await getAuthorizationHeader();
    if (null == header) {
      throw NoTokenException();
    }
    return chain.proceed(applyHeader(chain.request, 'Authorization', header));
  }
}
