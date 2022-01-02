import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

enum SettingsBanners {
  NOTIFICATIONS_MODULE_SUPPORT,
  QUICK_ACTIONS_SUPPORT,
  PROFILES_SUPPORT,
}

extension SettingsBannersExtension on SettingsBanners {
  String get key {
    return 'SETTINGS_${this.name}';
  }

  String get header {
    switch (this) {
      case SettingsBanners.NOTIFICATIONS_MODULE_SUPPORT:
        return 'settings.BannersNotificationModuleSupportHeader'.tr();
      case SettingsBanners.QUICK_ACTIONS_SUPPORT:
        return 'settings.QuickActions'.tr();
      case SettingsBanners.PROFILES_SUPPORT:
        return 'settings.Profiles'.tr();
    }
  }

  String get body {
    switch (this) {
      case SettingsBanners.NOTIFICATIONS_MODULE_SUPPORT:
        return 'settings.BannersNotificationModuleSupportBody'.tr();
      case SettingsBanners.QUICK_ACTIONS_SUPPORT:
        return [
          'Quick actions allow you to quickly jump into modules directly from the home screen or launcher on your device by long pressing LunaSea\'s icon.',
          'A limited number of quick actions can be set at a time, and enabling more than your launcher can support will have no effect.'
        ].join('\n\n');

      case SettingsBanners.PROFILES_SUPPORT:
        return [
          'Profiles allow you to add multiple instances of modules into LunaSea. You can switch between profiles in the main navigation drawer.',
          'Newznab indexer searching and external modules are enabled and shared across all profiles.',
        ].join('\n\n');
    }
  }

  Color get iconColor {
    switch (this) {
      case SettingsBanners.NOTIFICATIONS_MODULE_SUPPORT:
      case SettingsBanners.QUICK_ACTIONS_SUPPORT:
      case SettingsBanners.PROFILES_SUPPORT:
      default:
        return LunaColours.accent;
    }
  }

  IconData get icon {
    switch (this) {
      case SettingsBanners.NOTIFICATIONS_MODULE_SUPPORT:
        return Icons.info_outline_rounded;
      case SettingsBanners.QUICK_ACTIONS_SUPPORT:
        return Icons.rounded_corner_rounded;
      case SettingsBanners.PROFILES_SUPPORT:
        return LunaIcons.PROFILES;
    }
  }

  /// Return true if the banner should be shown in the UI
  bool? get shouldShow => Database.alertsBox.get(key, defaultValue: true);

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
          if (shouldShow!)
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
