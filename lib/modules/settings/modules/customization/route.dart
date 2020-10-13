import 'dart:io';
import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsCustomizationRouter {
    static const ROUTE_NAME = '/settings/customization';

    static Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;
    
    static void defineRoutes(Router router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => _SettingsCustomizationRoute()),
        transitionType: LunaRouter.transitionType,
    );

    SettingsCustomizationRouter._();
}

class _SettingsCustomizationRoute extends StatefulWidget {
    @override
    State<_SettingsCustomizationRoute> createState() => _State();
}

class _State extends State<_SettingsCustomizationRoute> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    bool get wantKeepAlive => true;

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar,
            body: _body,
        );
    }

    Widget get _appBar => LunaAppBar(
        context: context,
        popUntil: '/settings',
        title: 'Customization',
    );

    Widget get _body => LSListView(
        children: [
            ..._general,
            LSDivider(),
            ..._modules,
        ],
    );

    List<Widget> get _general => [
        LSCardTile(
            title: LSTitle(text: 'Appearance'),
            subtitle: LSSubtitle(text: 'Appearance Customizations'),
            trailing: LSIconButton(icon: Icons.brush),
            onTap: () async => SettingsCustomizationAppearanceRouter.navigateTo(context),
        ),
        LSCardTile(
            title: LSTitle(text: 'Drawer'),
            subtitle: LSSubtitle(text: 'Drawer Customizations'),
            trailing: LSIconButton(icon: Icons.dehaze),
            onTap: () async => SettingsCustomizationDrawerRouter.navigateTo(context),
        ),
        if(Platform.isIOS) SettingsCustomizationBrowserTile(),
        LSCardTile(
            title: LSTitle(text: 'Quick Actions'),
            subtitle: LSSubtitle(text: 'Quick Actions on the Home Screen'),
            trailing: LSIconButton(icon: Icons.rounded_corner),
            onTap: () async => SettingsCustomizationQuickActionsRouter.navigateTo(context),
        ),
    ];

    List<Widget> get _modules => [
        LSCardTile(
            title: LSTitle(text: 'Calendar'),
            subtitle: LSSubtitle(text: 'Calendar Customizations'),
            trailing: LSIconButton(icon: CustomIcons.calendar),
            onTap: () async => SettingsCustomizationCalendarRouter.navigateTo(context),
        ),
        LSCardTile(
            title: LSTitle(text: 'Home'),
            subtitle: LSSubtitle(text: 'Home Customizations'),
            trailing: LSIconButton(icon: CustomIcons.home),
            onTap: () async => SettingsCustomizationHomeRouter.navigateTo(context),
        ),
        LSCardTile(
            title: LSTitle(text: 'Search'),
            subtitle: LSSubtitle(text: 'Search Customizations'),
            trailing: LSIconButton(icon: Icons.search),
            onTap: () async => SettingsCustomizationSearchRouter.navigateTo(context),
        ),
        LSDivider(),
        LSCardTile(
            title: LSTitle(text: 'Lidarr'),
            subtitle: LSSubtitle(text: 'Lidarr Customizations'),
            trailing: LSIconButton(icon: CustomIcons.music),
            onTap: () async => SettingsCustomizationLidarrRouter.navigateTo(context),
        ),
        LSCardTile(
            title: LSTitle(text: 'Radarr'),
            subtitle: LSSubtitle(text: 'Radarr Customizations'),
            trailing: LSIconButton(icon: CustomIcons.movies),
            onTap: () async => SettingsCustomizationRadarrRouter.navigateTo(context),
        ),
        LSCardTile(
            title: LSTitle(text: 'Sonarr'),
            subtitle: LSSubtitle(text: 'Sonarr Customizations'),
            trailing: LSIconButton(icon: CustomIcons.television),
            onTap: () async => SettingsCustomizationSonarrRouter.navigateTo(context),
        ),
        LSDivider(),
        LSCardTile(
            title: LSTitle(text: 'NZBGet'),
            subtitle: LSSubtitle(text: 'NZBGet Customizations'),
            trailing: LSIconButton(icon: CustomIcons.nzbget),
            onTap: () async => SettingsCustomizationNZBGetRouter.navigateTo(context),
        ),
        LSCardTile(
            title: LSTitle(text: 'SABnzbd'),
            subtitle: LSSubtitle(text: 'SABnzbd Customizations'),
            trailing: LSIconButton(icon: CustomIcons.sabnzbd),
            onTap: () async => SettingsCustomizationSABnzbdRouter.navigateTo(context),
        ),
        LSDivider(),
        LSCardTile(
            title: LSTitle(text: 'Tautulli'),
            subtitle: LSSubtitle(text: 'Tautulli Customizations'),
            trailing: LSIconButton(icon: CustomIcons.tautulli),
            onTap: () async => SettingsCustomizationTautulliRouter.navigateTo(context),
        ),
    ];
}
