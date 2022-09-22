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
          'settings.QuickActionsBannerLine1'.tr(),
          'settings.QuickActionsBannerLine2'.tr(),
        ].join('\n\n');

      case SettingsBanners.PROFILES_SUPPORT:
        return [
          'settings.ProfilesBannerLine1'.tr(),
          'settings.ProfilesBannerLine2'.tr(),
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
  bool? get shouldShow => LunaBox.alerts.read(key, fallback: true);

  /// Mark the banner as seen, so it will not appear in the UI anymore
  void markSeen() => LunaBox.alerts.update(key, false);

  /// Create a new [ValueListenableBuilder]
  ValueListenableBuilder banner({
    Color headerColor = Colors.white,
    Color bodyColor = LunaColours.grey,
  }) {
    return LunaBox.alerts.listenableBuilder(
      selectKeys: [key],
      builder: (context, _) {
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
}
