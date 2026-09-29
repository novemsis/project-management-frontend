import 'dart:async';

import 'package:chopper/chopper.dart';

class TokenExpiredException implements Exception {
  @override
  String toString() => 'TokenExpiredException: authorization token was invalid';
}

class AuthorizationResponseInterceptor implements Interceptor {
  AuthorizationResponseInterceptor();

  @override
  Future<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async {
    final response = await chain.proceed(chain.request);
    if (!response.isSuccessful && response.statusCode == 401) {
      throw new TokenExpiredException();
    }

    return response;
  }
}
