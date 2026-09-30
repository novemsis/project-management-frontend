import 'dart:convert';

import 'package:chopper/chopper.dart' hide HttpMethod;
import 'package:riverbloc/riverbloc.dart';

import '../../../core/api/api.dart';
import '../../../core/api/api_cubit.dart';
import '../../../core/api/request_body.dart';

class ProjectCreateCubit extends Cubit<ProjectCreateState> {
  static final provider = BlocProvider<ProjectCreateCubit, ProjectCreateState>((ref) {
    final projectCubit = ProjectCreateCubit(
      apiCubit: ref.read(ApiCubit.provider.bloc),
    );
    ref.onDispose(() => projectCubit.close());
    return projectCubit;
  });

  final ApiCubit _apiCubit;

  ProjectCreateCubit({required this._apiCubit}) : super(ProjectCreateState.initial());

  Future<String?> createProject(String title, String? description) async {
    emit(ProjectCreateState.loading());

    final Response<dynamic>? response = await _apiCubit.performCallToRoute(
      path: '/project/create',
      method: HttpMethod.post,
      authenticated: true,
      body: CreateProjectDto(title: title, description: description),
    );

    if (!(response?.isSuccessful ?? false) || response!.body == null || response.body!.toString().isEmpty) {
      emit(ProjectCreateState.error());
      return null;
    }
    emit(ProjectCreateState.success());

    final body = jsonDecode(response.body.toString()) as Map<String, dynamic>;
    if (!body.containsKey('id')) {
      return null;
    }

    return body['id'] as String;
  }
}

class CreateProjectDto extends RequestBody {
  final String _title;
  final String? _description;

  CreateProjectDto({required this._title, required this._description});

  Map<String, dynamic> toJson() {
    return {
      'title': _title,
      'description': _description,
    };
  }
}

sealed class ProjectCreateState {
  const ProjectCreateState();

  factory ProjectCreateState.initial() = ProjectCreateStateInitial;

  factory ProjectCreateState.loading() = ProjectCreateStateLoading;

  factory ProjectCreateState.success() = ProjectCreateStateSuccess;

  factory ProjectCreateState.error() = ProjectCreateStateError;
}

final class ProjectCreateStateInitial extends ProjectCreateState {
  const ProjectCreateStateInitial();
}

final class ProjectCreateStateLoading extends ProjectCreateState {
  const ProjectCreateStateLoading();
}

final class ProjectCreateStateSuccess extends ProjectCreateState {
  const ProjectCreateStateSuccess();
}

final class ProjectCreateStateError extends ProjectCreateState {
  const ProjectCreateStateError();
}
