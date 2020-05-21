import 'package:lunasea/core.dart';

class WakeOnLANAPI extends API {
    void logWarning(String methodName, String text) => Logger.warning('package:lunasea/modules/wake_on_lan/core/api.dart', methodName, 'Wake on LAN: $text');
    void logError(String methodName, String text, Object error) => Logger.error('package:lunasea/modules/wake_on_lan/core/api.dart', methodName, 'Wake on LAN: $text', error, StackTrace.current);

    Future<bool> testConnection() async => true;
}
