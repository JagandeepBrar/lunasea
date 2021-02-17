import 'dart:io';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules.dart';

class SettingsConfigurationRouter extends LunaPageRouter {
    SettingsConfigurationRouter() : super('/settings/configuration');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationRoute());
}

class _SettingsConfigurationRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar(),
            body: _body(),
        );
    }

    Widget _appBar() {
        return LunaAppBar(
            state: context.read<SettingsState>(),
            title: 'Configuration',
            actions: [_appBarProfileButton()],
        );
    }

    Widget _appBarProfileButton() {
        return LunaIconButton(
            icon: Icons.person,
            onPressed: () async {
                List<dynamic> values = await SettingsDialogs.enabledProfile(
                    context,
                    Database.profilesBox.keys.map((x) => x as String).toList()..sort((a,b) => a.toLowerCase().compareTo(b.toLowerCase())),
                );
                if(values[0] && values[1] != LunaDatabaseValue.ENABLED_PROFILE.data) LunaProfile().safelyChangeProfiles(context, values[1]);
            },
        );
    }

    Widget _body() {
        return LunaListView(
            scrollController: context.read<SettingsState>().scrollController,
            children: [
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Appearance'),
                    subtitle: LunaText.subtitle(text: 'Customize the Look & Feel'),
                    trailing: LunaIconButton(icon: Icons.brush),
                    onTap: () async => SettingsConfigurationAppearanceRouter().navigateTo(context),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Drawer'),
                    subtitle: LunaText.subtitle(text: 'Drawer Customizations'),
                    trailing: LunaIconButton(icon: Icons.dehaze),
                    onTap: () async => SettingsConfigurationDrawerRouter().navigateTo(context),
                ),
                if(Platform.isIOS) LunaDatabaseValue.SELECTED_BROWSER.listen(
                    builder: (context, box, widget) => LunaListTile(
                        context: context,
                        title: LunaText.title(text: 'Open Links In...'),
                        subtitle: LunaText.subtitle(text: (LunaDatabaseValue.SELECTED_BROWSER.data as LunaBrowser).name),
                        trailing: LunaIconButton(icon: (LunaDatabaseValue.SELECTED_BROWSER.data as LunaBrowser).icon),
                        onTap: () async {
                            Tuple2<bool, LunaBrowser> result = await SettingsDialogs.changeBrowser(context);
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
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Home'),
                    subtitle: LunaText.subtitle(text: 'Configure the Home Screen'),
                    trailing: LunaIconButton(icon: CustomIcons.home),
                    onTap: () async => SettingsConfigurationHomeRouter().navigateTo(context),
                ),
                _tileFromModuleMap(SearchConstants.MODULE_METADATA, () async => SettingsConfigurationSearchRouter().navigateTo(context)),
                _tileFromModuleMap(WakeOnLANConstants.MODULE_METADATA, () async => SettingsConfigurationWakeOnLANRouter().navigateTo(context)),
                LunaDivider(),
                _tileFromModuleMap(LidarrConstants.MODULE_METADATA, () async => SettingsConfigurationLidarrRouter().navigateTo(context)),
                _tileFromModuleMap(RadarrConstants.MODULE_METADATA, () async => SettingsConfigurationRadarrRouter().navigateTo(context)),
                _tileFromModuleMap(SonarrConstants.MODULE_METADATA, () async => SettingsConfigurationSonarrRouter().navigateTo(context)),
                LunaDivider(),
                _tileFromModuleMap(NZBGetConstants.MODULE_METADATA, () async => SettingsConfigurationNZBGetRouter().navigateTo(context)),
                _tileFromModuleMap(SABnzbdConstants.MODULE_METADATA, () async => SettingsConfigurationSABnzbdRouter().navigateTo(context)),
                LunaDivider(),
                _tileFromModuleMap(TautulliConstants.MODULE_METADATA, () async => SettingsConfigurationTautulliRouter().navigateTo(context)),
            ],
        );
    }

    Widget _tileFromModuleMap(LunaModuleMetadata map, Function onTap) {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: map.name),
            subtitle: LunaText.subtitle(text: map.settingsDescription),
            trailing: LunaIconButton(icon: map.icon),
            onTap: onTap,
        );
    }
}
