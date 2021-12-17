import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsNotificationsRouter extends SettingsPageRouter {
  SettingsNotificationsRouter() : super('/settings/notifications');

  @override
  _Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) =>
      super.noParameterRouteDefinition(router);
}

class _Widget extends StatefulWidget {
  @override
  State<_Widget> createState() => _State();
}

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'Notifications',
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
            if (snapshot.hasData && !snapshot.data)
              return const LunaBanner(
                headerText: 'Not Authorized',
                bodyText:
                    'LunaSea is not authorized to show notifications. Please go to your device\'s settings to enable notifications.',
                icon: Icons.error_outline_rounded,
                iconColor: LunaColours.red,
              );
            return const SizedBox(height: 0.0, width: double.infinity);
          },
        ),
        SettingsBanners.NOTIFICATIONS_MODULE_SUPPORT.banner(),
        LunaBlock(
          title: 'Getting Started',
          body: const [TextSpan(text: 'Information & Setup Instructions')],
          trailing: const LunaIconButton.arrow(),
          onTap:
              LunaLinks.NOTIFICATIONS_GETTING_STARTED.url.lunaOpenGenericLink,
        ),
        const LunaDivider(),
        ..._modules(),
      ],
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
