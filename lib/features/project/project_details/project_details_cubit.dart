import 'dart:convert';

import 'package:chopper/chopper.dart' hide HttpMethod;
import 'package:riverbloc/riverbloc.dart';

import '../../../core/api/api.dart';
import '../../../core/api/api_cubit.dart';
import '../project_model.dart';

class ProjectDetailsCubit extends Cubit<ProjectDetailsState> {
  static final provider = BlocProvider.family.autoDispose<ProjectDetailsCubit, ProjectDetailsState, String>((ref, projectId) {
    final projectCubit = ProjectDetailsCubit(
      projectId: projectId,
      apiCubit: ref.read(ApiCubit.provider.bloc),
    );
    ref.onDispose(() => projectCubit.close());
    return projectCubit;
  });

  final String _projectId;
  final ApiCubit _apiCubit;

  ProjectDetailsCubit({required this._projectId, required this._apiCubit}) : super(ProjectDetailsState.initial()) {
    loadProject();
  }

  void loadProject() async {
    emit(ProjectDetailsState.loading());

    final Response<dynamic>? response = await _apiCubit.performCallToRoute(
      path: '/project/${_projectId}',
      method: HttpMethod.get,
      authenticated: true,
    );
    if (!(response?.isSuccessful ?? false) || response?.body == null) {
      emit(ProjectDetailsState.error());
      return;
    }
    final loadingTime = DateTime.now();

    final body = jsonDecode(response!.body.toString());
    emit(ProjectDetailsState.success(buildModelFromRequestBody(body, loadingTime)));

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

sealed class ProjectDetailsState {
  const ProjectDetailsState();

  factory ProjectDetailsState.initial() = ProjectDetailsStateInitial;

  factory ProjectDetailsState.loading() = ProjectDetailsStateLoading;

  factory ProjectDetailsState.success(ProjectModel project) = ProjectDetailsStateSuccess;

  factory ProjectDetailsState.error() = ProjectDetailsStateError;
}

final class ProjectDetailsStateInitial extends ProjectDetailsState {
  const ProjectDetailsStateInitial();
}

final class ProjectDetailsStateLoading extends ProjectDetailsState {
  const ProjectDetailsStateLoading();
}

final class ProjectDetailsStateSuccess extends ProjectDetailsState {
  final ProjectModel _project;

  const ProjectDetailsStateSuccess(this._project);

  ProjectModel get project => _project;
}

final class ProjectDetailsStateError extends ProjectDetailsState {
  const ProjectDetailsStateError();
}
