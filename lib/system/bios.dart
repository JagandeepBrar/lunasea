import 'package:lunasea/database/tables/bios.dart';
import 'package:lunasea/firebase/firestore.dart';
import 'package:lunasea/firebase/messaging.dart';
import 'package:lunasea/system/build.dart';
import 'package:lunasea/system/localization.dart';
import 'package:lunasea/system/quick_actions/quick_actions.dart';
import 'package:lunasea/widgets/sheets/changelog/sheet.dart';
import 'package:lunasea/widgets/sheets/database_corruption/sheet.dart';

class LunaBIOS {
  Future<void> boot() async {
    LunaLanguage.current.use();
    _initNotifications();
    if (LunaQuickActions.isSupported) LunaQuickActions().initialize();

    await _healthCheck();
    BIOSDatabase.FIRST_BOOT.update(false);
  }

  Future<void> _initNotifications() async {
    if (LunaFirebaseMessaging.isSupported) {
      final messaging = LunaFirebaseMessaging();
      final firestore = LunaFirebaseFirestore();
      await messaging.requestNotificationPermissions();

      firestore.addDeviceToken();
      messaging.checkAndHandleInitialMessage();
      messaging.registerOnMessageListener();
      messaging.registerOnMessageOpenedAppListener();
    }
  }

  Future<void> _healthCheck() async {
    final isLatest = LunaBuild().isLatestBuildVersion();
    final firstBoot = BIOSDatabase.FIRST_BOOT.read();

    if (BIOSDatabase.DATABASE_CORRUPTION.read()) {
      DatabaseCorruptionSheet().show();
      BIOSDatabase.DATABASE_CORRUPTION.update(false);
    }

    if (!firstBoot && !isLatest.item1) {
      ChangelogSheet().show();
    }
  }
}
