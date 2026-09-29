import 'package:riverbloc/riverbloc.dart';

import '../../../core/api/api_cubit.dart';

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
