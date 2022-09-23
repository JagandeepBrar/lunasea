import 'package:flutter/material.dart';
import 'package:lunasea/database/tables/bios.dart';
import 'package:lunasea/firebase/firestore.dart';
import 'package:lunasea/firebase/messaging.dart';
import 'package:lunasea/system/build.dart';
import 'package:lunasea/system/localization.dart';
import 'package:lunasea/system/quick_actions/quick_actions.dart';
import 'package:lunasea/widgets/sheets/changelog/sheet.dart';

class LunaOS {
  Future<void> boot(BuildContext context) async {
    LunaLanguage.current(context).use(context);
    _initNotifications();
    if (LunaQuickActions.isSupported) LunaQuickActions().initialize();
    Future.microtask(_healthCheck);
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

    if (!firstBoot && !isLatest.item1) {
      ChangelogSheet().show();
    }

    BIOSDatabase.FIRST_BOOT.update(false);
  }
}
