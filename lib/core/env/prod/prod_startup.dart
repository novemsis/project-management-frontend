import '../../app_config.dart';
import '../../startup.dart';

class ProdStartup extends Startup {
  @override
  AppConfig get appConfig {
    String backendUrl = 'backend.visionflow.de/api';
    return AppConfig(apiUri: Uri.parse(backendUrl));
  }
}
