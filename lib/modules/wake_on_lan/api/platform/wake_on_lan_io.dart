import 'package:lunasea/database/models/profile.dart';
import 'package:lunasea/widgets/ui.dart';
import 'package:lunasea/system/logger.dart';
import 'package:wake_on_lan/wake_on_lan.dart';

// ignore: always_use_package_imports
import '../wake_on_lan.dart';

bool isPlatformSupported() => true;
LunaWakeOnLAN getWakeOnLAN() => IO();

class IO implements LunaWakeOnLAN {
  @override
  Future<void> wake() async {
    LunaProfile profile = LunaProfile.current;
    try {
      final ip = IPv4Address(profile.wakeOnLANBroadcastAddress);
      final mac = MACAddress(profile.wakeOnLANMACAddress);
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
