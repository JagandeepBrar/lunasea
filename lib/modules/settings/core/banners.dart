import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

enum SettingsBanners {
  NOTIFICATIONS_MODULE_SUPPORT,
}

extension SettingsBannersExtension on SettingsBanners {
  String get key {
    switch (this) {
      case SettingsBanners.NOTIFICATIONS_MODULE_SUPPORT:
        return 'SETTINGS_NOTIFICATIONS_MODULE_SUPPORT';
    }
    throw Exception('Invalid SettingsBanners');
  }

  String get header {
    switch (this) {
      case SettingsBanners.NOTIFICATIONS_MODULE_SUPPORT:
        return 'settings.BannersNotificationModuleSupportHeader'.tr();
    }
    throw Exception('Invalid SettingsBanners');
  }

  String get body {
    switch (this) {
      case SettingsBanners.NOTIFICATIONS_MODULE_SUPPORT:
        return 'settings.BannersNotificationModuleSupportBody'.tr();
    }
    throw Exception('Invalid SettingsBanners');
  }

  Color get iconColor {
    switch (this) {
      case SettingsBanners.NOTIFICATIONS_MODULE_SUPPORT:
        return LunaColours.accent;
    }
    throw Exception('Invalid SettingsBanners');
  }

  IconData get icon {
    switch (this) {
      case SettingsBanners.NOTIFICATIONS_MODULE_SUPPORT:
        return Icons.info_outline_rounded;
    }
    throw Exception('Invalid SettingsBanners');
  }

  /// Return true if the banner should be shown in the UI
  bool get shouldShow => Database.alertsBox.get(key, defaultValue: true);

  /// Mark the banner as seen, so it will not appear in the UI anymore
  void markSeen() => Database.alertsBox.put(key, false);

  /// Create a new [ValueListenableBuilder]
  ValueListenableBuilder banner({
    Color headerColor = Colors.white,
    Color bodyColor = LunaColours.grey,
  }) =>
      ValueListenableBuilder(
        valueListenable: Database.alertsBox.listenable(keys: [key]),
        builder: (context, box, _) {
          if (shouldShow)
            return LunaBanner(
              dismissCallback: markSeen,
              headerText: header,
              bodyText: body,
              icon: icon,
              iconColor: iconColor,
              headerColor: headerColor,
              bodyColor: bodyColor,
            );
          return const SizedBox(height: 0.0, width: double.infinity);
        },
      );
}
