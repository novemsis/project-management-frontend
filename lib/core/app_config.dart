// coverage:ignore-file

import 'package:riverpod/riverpod.dart';

class AppConfig {
  final Uri apiUri;

  static final provider = Provider<AppConfig>((ref) => throw StateError('AppConfig has not been overridden'));

  const AppConfig({required this.apiUri});
}