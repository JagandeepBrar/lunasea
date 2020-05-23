import 'package:lunasea/core.dart';

class WakeOnLANAPI extends API {
    final Map<String, dynamic> _values;

    WakeOnLANAPI._internal(this._values);
    factory WakeOnLANAPI.from(ProfileHiveObject profile) => WakeOnLANAPI._internal(profile.getWakeOnLAN());

    void logWarning(String methodName, String text) => Logger.warning('package:lunasea/modules/wake_on_lan/core/api.dart', methodName, 'Wake on LAN: $text');
    void logError(String methodName, String text, Object error) => Logger.error('package:lunasea/modules/wake_on_lan/core/api.dart', methodName, 'Wake on LAN: $text', error, StackTrace.current);

    bool get enabled => _values['enabled'];
    String get broadcastAddress => _values['broadcastAddress'];
    String get macAddress => _values['MACAddress'];

    Future<bool> testConnection() async => true;

    Future<bool> wake() async {
        return true;
    }
}
