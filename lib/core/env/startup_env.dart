// coverage:ignore-file

import 'package:project_management_frontend/core/env/prod/prod_startup.dart';

import '../startup.dart';
import 'local/local_startup.dart';

enum Environment {
  local('local'),
  prod('prod');

  final String value;
  const Environment(this.value);
}

const environment = String.fromEnvironment('ENVIRONMENT', defaultValue: 'local');

Startup startupFromEnv([String env = environment]) {
  final parsedEnv = Environment.values.firstWhere(
        (e) => e.value == env,
    orElse: () => throw ArgumentError.value(env, 'ENVIRONMENT', 'invalid environment, must be one of ${Environment.values}'),
  );
  return switch (parsedEnv) {
    Environment.local => LocalStartup(),
    Environment.prod => ProdStartup(),
  };
}
