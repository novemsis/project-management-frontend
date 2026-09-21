// coverage:ignore-file

import 'package:riverpod/src/framework.dart';

import 'app_config.dart';

abstract class Startup {
  AppConfig get appConfig;

  ProviderContainer initBasicServices({List<Override> overrides = const []}) {
    final container = ProviderContainer(
      overrides: [
        ...overrides,
        AppConfig.provider.overrideWith((ref) => appConfig),
      ],
    );

    return container;
  }
}
