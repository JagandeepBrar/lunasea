import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsNotificationsRouter extends SettingsPageRouter {
    SettingsNotificationsRouter() : super('/settings/notifications');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsNotificationsRoute());
}

class _SettingsNotificationsRoute extends StatefulWidget {
    @override
    State<_SettingsNotificationsRoute> createState() => _State();
}

class _State extends State<_SettingsNotificationsRoute> with LunaScrollControllerMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
        return  LunaScaffold(
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
                SettingsBanners.NOTIFICATIONS_MODULE_SUPPORT.banner(),
                _idButtons(),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Getting Started'),
                    subtitle: LunaText.subtitle(text: 'Preparation and Basic Information'),
                    trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
                    onTap: LunaLinks.NOTIFICATIONS_GETTING_STARTED.url.lunaOpenGenericLink,
                ),
                LunaDivider(),
                ..._modules(),
            ],
        );
    }

    List<Widget> _modules() {
        List<LunaListTile> modules = [];
        LunaModule.values.forEach((module) {
            if(module.notificationDocs?.isNotEmpty ?? false) modules.add(LunaListTile(
                context: context,
                title: LunaText.title(text: module.name),
                subtitle: LunaText.subtitle(text: 'Notification Guide for ${module.name}'),
                trailing: LunaIconButton(icon: module.icon),
                onTap: module.notificationDocs.lunaOpenGenericLink,
            ));
        });
        return modules;
    }

    Widget _idButtons() {
        return LunaButtonContainer(
            children: [
                if(LunaFirebaseAuth().isSignedIn) LunaButton.text(
                    text: 'User Token',
                    icon: Icons.person_rounded,
                    onTap: () async {
                        if(!LunaFirebaseAuth().isSignedIn) return;
                        String userId = LunaFirebaseAuth().uid;
                        await Clipboard.setData(ClipboardData(text: userId));
                        showLunaInfoSnackBar(
                            title: 'Copied User Token',
                            message: 'Copied your user token to the clipboard',
                        );
                    },
                    backgroundColor: Theme.of(context).cardColor,
                ),
                LunaButton.text(
                    text: 'Device Token',
                    icon: Icons.devices_rounded,
                    backgroundColor: Theme.of(context).cardColor,
                    onTap: () async {
                        String deviceId = await LunaFirebaseMessaging().token;
                        await Clipboard.setData(ClipboardData(text: deviceId));
                        showLunaInfoSnackBar(
                            title: 'Copied Device Token',
                            message: 'Copied your device token to the clipboard',
                        );
                    },
                )
            ],
        );
    }
}
