import 'dart:convert';

import 'package:chopper/chopper.dart' hide HttpMethod;
import 'package:riverbloc/riverbloc.dart';

import '../../core/api/api.dart';
import '../../core/api/api_cubit.dart';
import '../project/project_model.dart';

class HomeCubit extends Cubit<HomeState> {
  static final BlocProvider<HomeCubit, HomeState> provider = BlocProvider<HomeCubit, HomeState>((ref) {
    final projectCubit = HomeCubit(
      apiCubit: ref.read(ApiCubit.provider.bloc),
    );
    ref.onDispose(() => projectCubit.close());
    return projectCubit;
  });

  final ApiCubit _apiCubit;

  HomeCubit({required this._apiCubit}) : super(HomeState.initial()) {
    loadProjects();
  }

  void loadProjects() async {
    emit(HomeState.loading());

    final Response<dynamic>? response = await _apiCubit.performCallToRoute(path: '/project/get-all', method: HttpMethod.get, authenticated: true);
    if (!(response?.isSuccessful ?? false) || response?.body == null) {
      emit(HomeState.error());
      return;
    }
    final loadingTime = DateTime.now();

    final List<ProjectModel> projects = [];
    jsonDecode(response!.body.toString()) as Map<String, dynamic>..forEach((key, value) {
      projects.add(buildModelFromRequestBody(value, loadingTime));
    });
    emit(HomeState.success(projects));

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

sealed class HomeState {
  const HomeState();

  factory HomeState.initial() = HomeStateInitial;

  factory HomeState.loading() = HomeStateLoading;

  factory HomeState.success(List<ProjectModel> projects) = HomeStateSuccess;

  factory HomeState.error() = HomeStateError;
}

final class HomeStateInitial extends HomeState {
  const HomeStateInitial();
}

final class HomeStateLoading extends HomeState {
  const HomeStateLoading();
}

final class HomeStateSuccess extends HomeState {
  final List<ProjectModel> _projects;

  const HomeStateSuccess(this._projects);

  List<ProjectModel> get projects => _projects;
}

final class HomeStateError extends HomeState {
  const HomeStateError();
}
