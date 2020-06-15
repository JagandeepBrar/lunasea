import 'dart:io';
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
        try {
            return await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0)
            .then((RawDatagramSocket socket) {
                socket.broadcastEnabled = true;
                socket.send(_packet, InternetAddress(broadcastAddress), 9);
                socket.close();
                return true;
            });
        } catch (error) {
            logError('wake', 'Failed to wake machine', error);
            return  Future.error(error);
        }
    }

    List<int> get _packet {
        MacAddress _mac = MacAddress.from(macAddress);
        List<int> _macBytes = _mac.bytes;
        List<int> _data = [];
        //Add 6 0xFF (255) bytes to the front
        for(int i=0; i<6; i++) _data.add(0xFF);
        //Add the Mac Address (bytes) 16 times to the packet
        for(int j=0; j<16; j++) _data.addAll(_macBytes);
        return _data;
    }
}
