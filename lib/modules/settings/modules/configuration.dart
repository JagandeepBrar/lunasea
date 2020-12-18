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
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Configuration',
        actions: [
            _profileButton,
        ],
    );

    Widget get _profileButton {
        Future<void> _execute() async {
            List<dynamic> values = await SettingsDialogs.enabledProfile(
                context,
                Database.profilesBox.keys.map((x) => x as String).toList()..sort((a,b) => a.toLowerCase().compareTo(b.toLowerCase())),
            );
            if(values[0] && values[1] != LunaDatabaseValue.ENABLED_PROFILE.data)
                LunaProfile().safelyChangeProfiles(context, values[1]);
        }
        return LSIconButton(
            icon: Icons.person,
            onPressed: _execute,
        );
    }

    Widget get _body => LSListView(
        children: [
            ..._customization,
            LSDivider(),
            ..._general,
            LSDivider(),
            ..._automation,
            LSDivider(),
            ..._clients,
            LSDivider(),
            ..._monitoring,
        ],
    );

    List<Widget> get _customization => [
        LSCardTile(
            title: LSTitle(text: 'Appearance'),
            subtitle: LSSubtitle(text: 'Customize the Look & Feel'),
            trailing: LSIconButton(icon: Icons.brush),
            onTap: () async => SettingsConfigurationAppearanceRouter().navigateTo(context),
        ),
        LSCardTile(
            title: LSTitle(text: 'Drawer'),
            subtitle: LSSubtitle(text: 'Drawer Customizations'),
            trailing: LSIconButton(icon: Icons.dehaze),
            onTap: () async => SettingsConfigurationDrawerRouter().navigateTo(context),
        ),
        if(Platform.isIOS) _openLinksInTile,
        LSCardTile(
            title: LSTitle(text: 'Quick Actions'),
            subtitle: LSSubtitle(text: 'Quick Actions on the Home Screen'),
            trailing: LSIconButton(icon: Icons.rounded_corner),
            onTap: () async => SettingsConfigurationQuickActionsRouter().navigateTo(context),
        ),
    ];

    List<Widget> get _general => [
        LSCardTile(
            title: LSTitle(text: 'Home'),
            subtitle: LSSubtitle(text: 'Configure the Home Screen'),
            trailing: LSIconButton(icon: CustomIcons.home),
            onTap: () async => SettingsConfigurationHomeRouter().navigateTo(context),
        ),
        _tileFromModuleMap(SearchConstants.MODULE_METADATA, () async => SettingsConfigurationSearchRouter().navigateTo(context)),
        _tileFromModuleMap(WakeOnLANConstants.MODULE_METADATA, () async => SettingsConfigurationWakeOnLANRouter().navigateTo(context)),
    ];

    List<Widget> get _automation => [
        _tileFromModuleMap(LidarrConstants.MODULE_METADATA, () async => SettingsConfigurationLidarrRouter().navigateTo(context)),
        _tileFromModuleMap(RadarrConstants.MODULE_METADATA, () async => SettingsConfigurationRadarrRouter().navigateTo(context)),
        _tileFromModuleMap(SonarrConstants.MODULE_METADATA, () async => SettingsConfigurationSonarrRouter().navigateTo(context)),
    ];

    List<Widget> get _clients => [
        _tileFromModuleMap(NZBGetConstants.MODULE_METADATA, () async => SettingsConfigurationNZBGetRouter().navigateTo(context)),
        _tileFromModuleMap(SABnzbdConstants.MODULE_METADATA, () async => SettingsConfigurationSABnzbdRouter().navigateTo(context)),
    ];

    List<Widget> get _monitoring => [
        _tileFromModuleMap(TautulliConstants.MODULE_METADATA, () async => SettingsConfigurationTautulliRouter().navigateTo(context)),
    ];

    Widget _tileFromModuleMap(LunaModuleMetadata map, Function onTap) => LSCardTile(
        title: LSTitle(text: map.name),
        subtitle: LSSubtitle(text: map.settingsDescription),
        trailing: LSIconButton(icon: map.icon),
        onTap: onTap,
    );

    Widget get _openLinksInTile {
        Future<void> _execute() async {
            List _values = await SettingsDialogs.changeBrowser(context);
            if(_values[0]) LunaDatabaseValue.SELECTED_BROWSER.put(_values[1]);
        }
        return ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [LunaDatabaseValue.SELECTED_BROWSER.key]),
            builder: (context, box, widget) => LSCardTile(
                title: LSTitle(text: 'Open Links In...'),
                subtitle: LSSubtitle(text: (LunaDatabaseValue.SELECTED_BROWSER.data as LSBrowsers).name),
                trailing: LSIconButton(
                    icon: (LunaDatabaseValue.SELECTED_BROWSER.data as LSBrowsers).icon,
                ),
                onTap: _execute,
            ),
        );
    }
}
