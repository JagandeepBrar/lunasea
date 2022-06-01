import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/firebase/auth.dart';
import 'package:lunasea/firebase/messaging.dart';

class SettingsNotificationsModuleTile extends StatelessWidget {
  final LunaModule module;

  const SettingsNotificationsModuleTile({
    Key? key,
    required this.module,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBanner(
      headerText: module.title,
      icon: module.icon,
      iconColor: module.color,
      bodyText: module.information,
      buttons: [
        if (LunaFirebaseAuth().isSignedIn)
          LunaButton.text(
            text: 'User',
            icon: Icons.person_rounded,
            onTap: () async {
              if (!LunaFirebaseAuth().isSignedIn) return;
              String? userId = LunaFirebaseAuth().uid;
              await Clipboard.setData(ClipboardData(
                  text: LunaWebhooks.buildUserTokenURL(userId, module)));
              showLunaInfoSnackBar(
                title: 'Copied URL for ${module.title}',
                message: 'Copied your user-based URL to the clipboard',
              );
            },
          ),
        LunaButton.text(
          text: 'Device',
          icon: Icons.devices_rounded,
          onTap: () async {
            String? deviceId = await LunaFirebaseMessaging().token;
            await Clipboard.setData(ClipboardData(
                text: LunaWebhooks.buildDeviceTokenURL(deviceId, module)));
            showLunaInfoSnackBar(
              title: 'Copied URL for ${module.title}',
              message: 'Copied your device-based URL to the clipboard',
            );
          },
        ),
      ],
    );
  }
}
