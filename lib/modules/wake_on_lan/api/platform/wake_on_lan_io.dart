import 'package:wake_on_lan/wake_on_lan.dart';

import '../../../../core/models/configuration/profile.dart';
import '../../../../core/system/profile.dart';
import '../../../../core/ui.dart';
import '../../../../core/utilities/logger.dart';
import '../wake_on_lan.dart';

bool isPlatformSupported() => true;
LunaWakeOnLAN getWakeOnLAN() => IO();

class IO implements LunaWakeOnLAN {
  @override
  Future<void> wake() async {
    ProfileHiveObject profile = LunaProfile.current;
    try {
      final ip = IPv4Address(profile.wakeOnLANBroadcastAddress ?? '');
      final mac = MACAddress(profile.wakeOnLANMACAddress ?? '');
      return WakeOnLAN(ip, mac).wake().then((_) {
        showLunaSuccessSnackBar(
          title: 'wake_on_lan.MagicPacketSent'.tr(),
          message: 'wake_on_lan.MagicPacketSentMessage'.tr(),
        );
      });
    } catch (error, stack) {
      LunaLogger().error(
        'Failed to send wake on LAN magic packet',
        error,
        stack,
      );
      showLunaErrorSnackBar(
        title: 'wake_on_lan.MagicPacketFailedToSend'.tr(),
        error: error,
      );
    }
  }
}
