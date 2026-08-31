import '../../app_config.dart';
import '../../startup.dart';

const String backendUrl = String.fromEnvironment('LOCAL_BACKEND_URL', defaultValue: 'http://localhost:8080');

class LocalStartup extends Startup {
  @override
  AppConfig get appConfig => AppConfig(apiUri: Uri.parse(backendUrl));
}