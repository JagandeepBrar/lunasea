import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsHomeRouter extends SettingsPageRouter {
    SettingsHomeRouter() : super('/settings');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsHomeRoute(), homeRoute: true);
}

class _SettingsHomeRoute extends StatefulWidget {
    @override
    State<_SettingsHomeRoute> createState() => _State();
}

class _State extends State<_SettingsHomeRoute> with LunaScrollControllerMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
        return LunaScaffold(
            scaffoldKey: _scaffoldKey,
            appBar: _appBar(),
            drawer: _drawer(),
            body: _body(),
        );
    }

    Widget _drawer() => LunaDrawer(page: LunaModule.SETTINGS.key);

    Widget _appBar() {
        return LunaAppBar(
            useDrawer: true,
            scrollControllers: [scrollController],
            title: LunaModule.SETTINGS.name,
        );
    }

    Widget _body() {
        return LunaListView(
            controller: scrollController,
            children: [
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Account'),
                    subtitle: LunaText.subtitle(text: 'Your LunaSea Account'),
                    trailing: LunaIconButton(icon: Icons.account_circle_rounded),
                    onTap: () async => SettingsAccountRouter().navigateTo(context),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Configuration'),
                    subtitle: LunaText.subtitle(text: 'Configure & Setup LunaSea'),
                    trailing: LunaIconButton(icon: Icons.device_hub_rounded),
                    onTap: () async => SettingsConfigurationRouter().navigateTo(context),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Notifications'),
                    subtitle: LunaText.subtitle(text: 'Setup Webhooks for Push Notifications'),
                    trailing: LunaIconButton(icon: Icons.notifications_none_rounded),
                    onTap: () async => SettingsNotificationsRouter().navigateTo(context),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Profiles'),
                    subtitle: LunaText.subtitle(text: 'Manage Your Profiles'),
                    trailing: LunaIconButton(icon: Icons.person_rounded),
                    onTap: () async => SettingsProfilesRouter().navigateTo(context),
                ),
                LunaDivider(),
                if(LunaInAppPurchases.isPlatformCompatible) LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Donations'),
                    subtitle: LunaText.subtitle(text: 'Donate to the Developer'),
                    trailing: LunaIconButton(icon: Icons.attach_money_rounded),
                    onTap: () async => SettingsDonationsRouter().navigateTo(context),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Resources'),
                    subtitle: LunaText.subtitle(text: 'Useful Resources & Links'),
                    trailing: LunaIconButton(icon: Icons.help_outline_rounded),
                    onTap: () async => SettingsResourcesRouter().navigateTo(context),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'System'),
                    subtitle: LunaText.subtitle(text: 'System Utilities & Information'),
                    trailing: LunaIconButton(icon: Icons.settings_rounded),
                    onTap: () async => SettingsSystemRouter().navigateTo(context),
                ),
            ],
        );
    }
}
