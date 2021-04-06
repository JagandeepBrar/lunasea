import 'dart:io';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules.dart';

class SettingsConfigurationRouter extends SettingsPageRouter {
    SettingsConfigurationRouter() : super('/settings/configuration');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationRoute());
}

class _SettingsConfigurationRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationRoute> with LunaScrollControllerMixin {
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
            title: 'Configuration',
            scrollControllers: [scrollController],
            actions: [
                LunaIconButton(
                    icon: Icons.person,
                    onPressed: () async {
                        List<dynamic> values = await SettingsDialogs.enabledProfile(
                            context,
                            Database.profilesBox.keys.map((x) => x as String).toList()..sort((a,b) => a.toLowerCase().compareTo(b.toLowerCase())),
                        );
                        if(values[0] && values[1] != LunaDatabaseValue.ENABLED_PROFILE.data) LunaProfile().safelyChangeProfiles(values[1]);
                    },
                ),
            ],
        );
    }

    Widget _body() {
        return LunaListView(
            controller: scrollController,
            children: [
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Appearance'),
                    subtitle: LunaText.subtitle(text: 'Customize the Look & Feel'),
                    trailing: LunaIconButton(icon: Icons.brush),
                    onTap: () async => SettingsConfigurationAppearanceRouter().navigateTo(context),
                ),
                if(Platform.isIOS) LunaDatabaseValue.SELECTED_BROWSER.listen(
                    builder: (context, box, widget) => LunaListTile(
                        context: context,
                        title: LunaText.title(text: 'Open Links In...'),
                        subtitle: LunaText.subtitle(text: (LunaDatabaseValue.SELECTED_BROWSER.data as LunaBrowser).name),
                        trailing: LunaIconButton(icon: (LunaDatabaseValue.SELECTED_BROWSER.data as LunaBrowser).icon),
                        onTap: () async {
                            Tuple2<bool, LunaBrowser> result = await SettingsDialogs().changeBrowser(context);
                            if(result.item1) LunaDatabaseValue.SELECTED_BROWSER.put(result.item2);  
                        },
                    ),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Quick Actions'),
                    subtitle: LunaText.subtitle(text: 'Quick Actions on the Home Screen'),
                    trailing: LunaIconButton(icon: Icons.rounded_corner),
                    onTap: () async => SettingsConfigurationQuickActionsRouter().navigateTo(context),
                ),
                LunaDivider(),
                _tileFromModuleMap(LunaModule.DASHBOARD, () async => SettingsConfigurationDashboardRouter().navigateTo(context)),
                _tileFromModuleMap(LunaModule.SEARCH, () async => SettingsConfigurationSearchRouter().navigateTo(context)),
                _tileFromModuleMap(LunaModule.WAKE_ON_LAN, () async => SettingsConfigurationWakeOnLANRouter().navigateTo(context)),
                LunaDivider(),
                _tileFromModuleMap(LunaModule.LIDARR, () async => SettingsConfigurationLidarrRouter().navigateTo(context)),
                _tileFromModuleMap(LunaModule.RADARR, () async => SettingsConfigurationRadarrRouter().navigateTo(context)),
                _tileFromModuleMap(LunaModule.SONARR, () async => SettingsConfigurationSonarrRouter().navigateTo(context)),
                LunaDivider(),
                _tileFromModuleMap(LunaModule.NZBGET, () async => SettingsConfigurationNZBGetRouter().navigateTo(context)),
                _tileFromModuleMap(LunaModule.SABNZBD, () async => SettingsConfigurationSABnzbdRouter().navigateTo(context)),
                LunaDivider(),
                _tileFromModuleMap(LunaModule.TAUTULLI, () async => SettingsConfigurationTautulliRouter().navigateTo(context)),
            ],
        );
    }

    Widget _tileFromModuleMap(LunaModule module, Function onTap) {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: module.name),
            subtitle: LunaText.subtitle(text: 'Configure ${module.name}'),
            trailing: LunaIconButton(icon: module.icon),
            onTap: onTap,
        );
    }
}
