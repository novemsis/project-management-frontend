class ProjectModel {
  final String id;
  final String title;
  final DateTime? projectStart;
  final DateTime? projectEnd;
  final DateTime createdAt;
  final DateTime? nextCheck;
  final ProjectTargetModel? target;
  final ProjectPlanModel? plan;
  final ProjectDecisionModel? decision;
  final List<ProjectToDo> toDos;
  final String? doneRatio;
  final DateTime loadingTime;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.projectStart,
    required this.projectEnd,
    required this.createdAt,
    required this.nextCheck,
    required this.target,
    required this.plan,
    required this.decision,
    required this.toDos,
    required this.doneRatio,
    required this.loadingTime,
  });
}

class ProjectTargetModel {
  final String id;
  final String? definition;
  final bool isSmarter;
  final bool? isSmarterSpezifisch;
  final bool? isSmarterMessbar;
  final bool? isSmarterAmbitioniert;
  final bool? isSmarterRealistisch;
  final bool? isSmarterTerminiert;
  final bool? isSmarterEmotionalisiert;
  final bool? isSmarterRessourceneinsetzend;
  final DateTime createdAt;

  ProjectTargetModel({
    required this.id,
    required this.definition,
    required this.isSmarter,
    required this.isSmarterSpezifisch,
    required this.isSmarterMessbar,
    required this.isSmarterAmbitioniert,
    required this.isSmarterRealistisch,
    required this.isSmarterTerminiert,
    required this.isSmarterEmotionalisiert,
    required this.isSmarterRessourceneinsetzend,
    required this.createdAt,
  });
}

class ProjectPlanModel {
  final String id;
  final bool isDefined;
  final String? strategicDefinition;
  final String? tacticalDefinition;
  final String? operationalDefinition;
  final DateTime createdAt;

  ProjectPlanModel({
    required this.id,
    required this.isDefined,
    required this.strategicDefinition,
    required this.tacticalDefinition,
    required this.operationalDefinition,
    required this.createdAt,
  });
}

class ProjectDecisionModel {
  final String id;
  final bool carryThrough;
  final String? description;
  final DateTime createdAt;

  ProjectDecisionModel({
    required this.id,
    required this.carryThrough,
    required this.description,
    required this.createdAt,
  });
}

class ProjectToDo {
  final String id;
  final String description;
  final bool isDone;
  final DateTime createdAt;

  ProjectToDo({
    required this.id,
    required this.description,
    required this.isDone,
    required this.createdAt,
  });
}
