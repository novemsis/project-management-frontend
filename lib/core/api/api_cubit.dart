import 'dart:convert';

import 'package:chopper/chopper.dart' hide HttpMethod;
import 'package:riverbloc/riverbloc.dart';

import 'api.dart';
import 'api_states.dart';
import 'authorization_header_interceptor.dart';
import 'request_body.dart';

class ApiCubit extends Cubit<ApiState> {
  static final BlocProvider<ApiCubit, ApiState> provider = BlocProvider<ApiCubit, ApiState>((ref) {
    final apiCubit = ApiCubit(
      authenticated: ref.read(authenticatedApiProvider),
      unauthenticated: ref.read(unauthenticatedApiProvider),
    );
    ref.onDispose(() => apiCubit.close());
    return apiCubit;
  });

  final ChopperClient _authenticated;
  final ChopperClient _unauthenticated;

  ApiCubit({required this._authenticated, required this._unauthenticated}) : super(ApiState.initial());

  Future<Response<dynamic>?> performCallToRoute({
    required String path,
    required HttpMethod method,
    bool authenticated = false,
    RequestBody? body,
  }) async {
    final client = authenticated ? _authenticated : _unauthenticated;

    final chopperRequest = Request(
      method.value,
      Uri.parse(path),
      client.baseUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: body == null ? null : jsonEncode(body.toJson()),
    );

    emit(ApiState.loading());

    try {
      final response = await client.send<dynamic, dynamic>(
        chopperRequest,
      );

      if (response.statusCode >= 200 && response.statusCode < 500) {
        emit(ApiState.initial());
        return response;
      } else {
        emit(ApiState.error());
      }
    } on NoTokenException catch (_) {
      emit(ApiState.tokenExpired());
    } catch (_) {
      emit(ApiState.error());
    }

    return null;
  }
}
