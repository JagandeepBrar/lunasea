import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/string/links.dart';
import 'package:lunasea/firebase/auth.dart';
import 'package:lunasea/firebase/messaging.dart';
import 'package:lunasea/system/webhooks.dart';

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
        LunaButton.text(
          text: 'settings.Device'.tr(),
          icon: Icons.devices_rounded,
          onTap: () async {
            String deviceId = (await LunaFirebaseMessaging().token)!;
            await Clipboard.setData(ClipboardData(
                text: LunaWebhooks.buildDeviceTokenURL(deviceId, module)));
            showLunaInfoSnackBar(
              title: 'settings.CopiedURLFor'.tr(args: [module.title]),
              message: 'settings.CopiedDeviceURL'.tr(),
            );
          },
        ),
        if (LunaFirebaseAuth().isSignedIn)
          LunaButton.text(
            text: 'settings.User'.tr(),
            icon: Icons.person_rounded,
            onTap: () async {
              if (!LunaFirebaseAuth().isSignedIn) return;
              String userId = LunaFirebaseAuth().uid!;
              await Clipboard.setData(ClipboardData(
                  text: LunaWebhooks.buildUserTokenURL(userId, module)));
              showLunaInfoSnackBar(
                title: 'settings.CopiedURLFor'.tr(args: [module.title]),
                message: 'settings.CopiedUserURL'.tr(),
              );
            },
          ),
        LunaButton.text(
          text: 'settings.Documentation'.tr(),
          icon: LunaIcons.DOCUMENTATION,
          color: LunaColours.blue,
          onTap: module.webhookDocs!.openLink,
        ),
      ],
    );
  }
}
