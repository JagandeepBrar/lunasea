import 'package:lunasea/core.dart';
import 'package:wake_on_lan/wake_on_lan.dart';

class WakeOnLANAPI {
  final bool? enabled;
  final String? broadcastAddress;
  final String? macAddress;

  WakeOnLANAPI._internal({
    required this.enabled,
    required this.broadcastAddress,
    required this.macAddress,
  });

  factory WakeOnLANAPI.fromProfile() {
    ProfileHiveObject profile = LunaProfile.current;
    return WakeOnLANAPI._internal(
      enabled: profile.wakeOnLANEnabled,
      broadcastAddress: profile.wakeOnLANBroadcastAddress,
      macAddress: profile.wakeOnLANMACAddress,
    );
  }

  Future<void> wake() async {
    IPv4Address ipv4 = IPv4Address(broadcastAddress!);
    MACAddress mac = MACAddress(macAddress!);
    return WakeOnLAN(ipv4, mac).wake();
  }
}
