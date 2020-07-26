import 'package:lunasea/core.dart';
import 'package:wake_on_lan/wake_on_lan.dart';

class WakeOnLANAPI extends API {
    final Map<String, dynamic> _values;

    WakeOnLANAPI._internal(this._values);
    factory WakeOnLANAPI.from(ProfileHiveObject profile) => WakeOnLANAPI._internal(profile.getWakeOnLAN());

    void logWarning(String methodName, String text) => Logger.warning('package:lunasea/modules/wake_on_lan/core/api.dart', methodName, 'Wake on LAN: $text');
    void logError(String methodName, String text, Object error, StackTrace trace) => Logger.error('package:lunasea/modules/wake_on_lan/core/api.dart', methodName, 'Wake on LAN: $text', error, trace);

    bool get enabled => _values['enabled'];
    String get broadcastAddress => _values['broadcastAddress'];
    String get macAddress => _values['MACAddress'];

    Future<bool> testConnection() async => true;

    Future<bool> wake() async {
        try {
            IPv4Address ipv4 = IPv4Address.from(broadcastAddress);
            MACAddress mac = MACAddress.from(macAddress);
            await WakeOnLAN.from(ipv4, mac).wake();
            return true;
        } catch (error) {
            logWarning('wake', 'Failed to wake machine');
            return  Future.error(error);
        }
    }
}
