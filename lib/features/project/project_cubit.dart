import 'dart:convert';

import 'package:chopper/chopper.dart' hide HttpMethod;
import 'package:riverbloc/riverbloc.dart';

import '../../core/api/api.dart';
import '../../core/api/api_cubit.dart';
import '../project/project_model.dart';

class ProjectCubit extends Cubit<ProjectState> {
  static final provider = BlocProvider.family.autoDispose<ProjectCubit, ProjectState, String>((ref, projectId) {
    final projectCubit = ProjectCubit(
      projectId: projectId,
      apiCubit: ref.read(ApiCubit.provider.bloc),
    );
    ref.onDispose(() => projectCubit.close());
    return projectCubit;
  });

  final String _projectId;
  final ApiCubit _apiCubit;

  ProjectCubit({required this._projectId, required this._apiCubit}) : super(ProjectState.initial()) {
    _loadProject();
  }

  void _loadProject() async {
    emit(ProjectState.loading());

    final Response<dynamic>? response = await _apiCubit.performCallToRoute(
      path: '/project/${_projectId}',
      method: HttpMethod.get,
      authenticated: true,
    );
    if (!(response?.isSuccessful ?? false) || response?.body == null) {
      emit(ProjectState.error());
      return;
    }
    final loadingTime = DateTime.now();

    final body = jsonDecode(response!.body.toString());
    emit(ProjectState.success(buildModelFromRequestBody(body, loadingTime)));

    return;
  }

  ProjectModel buildModelFromRequestBody(dynamic body, DateTime loadingTime) {
    return ProjectModel(
      id: body['id'] as String,
      title: body['title'] as String,
      projectStart: body['project_start'] != null ? DateTime.parse(body['project_start'] as String) as DateTime? : null,
      projectEnd: body['project_end'] != null ? DateTime.parse(body['project_end'] as String) : null,
      createdAt: DateTime.parse(body['created_at'] as String),
      nextCheck: body['next_check'] != null ? DateTime.parse(body['next_check'] as String) : null,
      target: body['target'] != null
          ? ProjectTargetModel(
              id: body['target']['id'] as String,
              definition: body['target']['definition'] as String?,
              isSmarter: body['target']['is_smarter'] as bool,
              isSmarterSpezifisch: body['target']['smarter_details']['is_spezifisch'] as bool?,
              isSmarterMessbar: body['target']['smarter_details']['is_messbar'] as bool?,
              isSmarterAmbitioniert: body['target']['smarter_details']['is_ambitioniert'] as bool?,
              isSmarterRealistisch: body['target']['smarter_details']['is_realistisch'] as bool?,
              isSmarterTerminiert: body['target']['smarter_details']['is_terminiert'] as bool?,
              isSmarterEmotionalisiert: body['target']['smarter_details']['is_emotionalisiert'] as bool?,
              isSmarterRessourceneinsetzend: body['target']['smarter_details']['is_ressourceneinsetzend'] as bool?,
              createdAt: DateTime.parse(body['target']['created_at'] as String),
            )
          : null,
      plan: body['plan'] != null
          ? ProjectPlanModel(
              id: body['plan']['id'] as String,
              isDefined: body['plan']['is_defined'] as bool,
              strategicDefinition: body['plan']['definition_details']['strategic'] as String?,
              tacticalDefinition: body['plan']['definition_details']['tactical'] as String?,
              operationalDefinition: body['plan']['definition_details']['operational'] as String?,
              createdAt: DateTime.parse(body['plan']['created_at'] as String),
            )
          : null,
      decision: body['decision'] != null
          ? ProjectDecisionModel(
              id: body['decision']['id'] as String,
              carryThrough: body['decision']['carry_through'] as bool,
              description: body['decision']['description'] as String?,
              createdAt: DateTime.parse(body['decision']['created_at'] as String),
            )
          : null,
      toDos: body['to_dos'] != null
          ? (body['to_dos'] as List<dynamic>).map((toDo) {
              return ProjectToDo(
                id: toDo['id'] as String,
                description: toDo['description'] as String,
                isDone: toDo['done'] as bool,
                createdAt: DateTime.parse(toDo['created_at'] as String),
              );
            }).toList()
          : [],
      doneRatio: body['done_to_dos_ratio'] != null ? body['done_to_dos_ratio'] as String : null,
      loadingTime: loadingTime,
    );
  }
}

sealed class ProjectState {
  const ProjectState();

  factory ProjectState.initial() = ProjectStateInitial;

  factory ProjectState.loading() = ProjectStateLoading;

  factory ProjectState.success(ProjectModel project) = ProjectStateSuccess;

  factory ProjectState.error() = ProjectStateError;
}

final class ProjectStateInitial extends ProjectState {
  const ProjectStateInitial();
}

final class ProjectStateLoading extends ProjectState {
  const ProjectStateLoading();
}

final class ProjectStateSuccess extends ProjectState {
  final ProjectModel _project;

  const ProjectStateSuccess(this._project);

  ProjectModel get project => _project;
}

final class ProjectStateError extends ProjectState {
  const ProjectStateError();
}
