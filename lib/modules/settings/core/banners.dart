import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

enum SettingsBanners {
    NOTIFICATIONS_MODULE_SUPPORT,
}

extension SettingsBannersExtension on SettingsBanners {
    String get key {
        switch(this) { 
            case SettingsBanners.NOTIFICATIONS_MODULE_SUPPORT: return 'SETTINGS_NOTIFICATIONS_MODULE_SUPPORT';
        }
        throw Exception('Invalid SettingsBanners');
    }

    String get header {
        switch(this) {
            case SettingsBanners.NOTIFICATIONS_MODULE_SUPPORT: return 'Supported Modules';
        }
        throw Exception('Invalid SettingsBanners');
    }

    String get body {
        switch(this) {
            case SettingsBanners.NOTIFICATIONS_MODULE_SUPPORT: return 'Webhook-based notifications are currently only supported in the modules listed below.\n\nAdditional module support will come in the future!';
        }
        throw Exception('Invalid SettingsBanners');
    }

    /// Return true if the banner should be shown in the UI
    bool get shouldShow => Database.alertsBox.get(this.key, defaultValue: true);
    
    /// Mark the banner as seen, so it will not appear in the UI anymore
    void markSeen() => Database.alertsBox.put(this.key, false);

    /// Create a new [ValueListenableBuilder] 
    ValueListenableBuilder banner({
        IconData icon = Icons.info_outline_rounded,
        Color iconColor = LunaColours.accent,
        Color backgroundColor,
        Color headerColor = Colors.white,
        Color bodyColor = Colors.white70,
    }) => ValueListenableBuilder(
        valueListenable: Database.alertsBox.listenable(keys: [this.key]),
        builder: (context, box, _) {
            if(this.shouldShow) return LunaBanner(
                dismissCallback: this.markSeen,
                headerText: this.header,
                bodyText: this.body,
                icon: icon,
                iconColor: iconColor,
                backgroundColor: backgroundColor,
                headerColor: headerColor,
                bodyColor: bodyColor,
            );
            return SizedBox(height: 0.0, width: double.infinity);
        }
    );
}
