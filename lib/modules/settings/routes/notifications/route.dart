import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/firebase/messaging.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/modules/settings/routes/notifications/widgets/module_tile.dart';
import 'package:lunasea/utils/links.dart';

class NotificationsRoute extends StatefulWidget {
  const NotificationsRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationsRoute> createState() => _State();
}

class _State extends State<NotificationsRoute> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'settings.Notifications'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        FutureBuilder(
          future: LunaFirebaseMessaging().areNotificationsAllowed(),
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData && !snapshot.data!)
              return LunaBanner(
                headerText: 'settings.NotAuthorized'.tr(),
                bodyText: 'settings.NotAuthorizedMessage'.tr(),
                icon: Icons.error_outline_rounded,
                iconColor: LunaColours.red,
              );
            return const SizedBox(height: 0.0, width: double.infinity);
          },
        ),
        SettingsBanners.NOTIFICATIONS_MODULE_SUPPORT.banner(),
        LunaBlock(
          title: 'settings.GettingStarted'.tr(),
          body: [TextSpan(text: 'settings.GettingStartedDescription'.tr())],
          trailing: const LunaIconButton.arrow(),
          onTap: LunaLinkedContent.NOTIFICATIONS_DOC.launch,
        ),
        _enableInAppNotifications(),
        LunaDivider(),
        ..._modules(),
      ],
    );
  }

  Widget _enableInAppNotifications() {
    const db = LunaSeaDatabase.ENABLE_IN_APP_NOTIFICATIONS;
    return LunaBlock(
      title: 'settings.EnableInAppNotifications'.tr(),
      trailing: db.listenableBuilder(
        builder: (context, _) => LunaSwitch(
          value: db.read(),
          onChanged: db.update,
        ),
      ),
    );
  }

  List<Widget> _modules() {
    List<SettingsNotificationsModuleTile> modules = [];
    for (LunaModule module in LunaModule.values) {
      if (module.hasWebhooks) {
        modules.add(SettingsNotificationsModuleTile(module: module));
      }
    }
    return modules;
  }
}
