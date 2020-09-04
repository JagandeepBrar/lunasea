import 'dart:io';
import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsCustomizationRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/customization';
    static String route() => ROUTE_NAME;

    static void defineRoute(Router router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => SettingsCustomizationRoute()),
        transitionType: LunaRouter.transitionType,
    );

    SettingsCustomizationRoute({
        Key key,
    }): super(key: key);

    @override
    State<SettingsCustomizationRoute> createState() => _State();
}

class _State extends State<SettingsCustomizationRoute> with AutomaticKeepAliveClientMixin {
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

    Widget get _appBar => LSAppBar(title: 'Customization');

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
            onTap: () async => SettingsRouter.router.navigateTo(context, SettingsCustomizationAppearanceRoute.route()),
        ),
        LSCardTile(
            title: LSTitle(text: 'Drawer'),
            subtitle: LSSubtitle(text: 'Drawer Customizations'),
            trailing: LSIconButton(icon: Icons.dehaze),
            onTap: () async => SettingsRouter.router.navigateTo(context, SettingsCustomizationDrawerRoute.route()),
        ),
        if(Platform.isIOS) SettingsCustomizationBrowserTile(),
        LSCardTile(
            title: LSTitle(text: 'Quick Actions'),
            subtitle: LSSubtitle(text: 'Quick Actions on the Home Screen'),
            trailing: LSIconButton(icon: Icons.rounded_corner),
            onTap: () async => SettingsRouter.router.navigateTo(context, SettingsCustomizationQuickActionsRoute.route()),
        ),
    ];

    List<Widget> get _modules => [
        LSCardTile(
            title: LSTitle(text: 'Calendar'),
            subtitle: LSSubtitle(text: 'Calendar Customizations'),
            trailing: LSIconButton(icon: CustomIcons.calendar),
            onTap: () async => SettingsRouter.router.navigateTo(context, SettingsCustomizationCalendarRoute.route()),
        ),
        LSCardTile(
            title: LSTitle(text: 'Home'),
            subtitle: LSSubtitle(text: 'Home Customizations'),
            trailing: LSIconButton(icon: CustomIcons.home),
            onTap: () async => SettingsRouter.router.navigateTo(context, SettingsCustomizationHomeRoute.route()),
        ),
        LSCardTile(
            title: LSTitle(text: 'Search'),
            subtitle: LSSubtitle(text: 'Search Customizations'),
            trailing: LSIconButton(icon: Icons.search),
            onTap: () async => SettingsRouter.router.navigateTo(context, SettingsCustomizationSearchRoute.route()),
        ),
        LSDivider(),
        LSCardTile(
            title: LSTitle(text: 'Lidarr'),
            subtitle: LSSubtitle(text: 'Lidarr Customizations'),
            trailing: LSIconButton(icon: CustomIcons.music),
            onTap: () async => SettingsRouter.router.navigateTo(context, SettingsCustomizationLidarrRoute.route()),
        ),
        LSCardTile(
            title: LSTitle(text: 'Radarr'),
            subtitle: LSSubtitle(text: 'Radarr Customizations'),
            trailing: LSIconButton(icon: CustomIcons.movies),
            onTap: () async => SettingsRouter.router.navigateTo(context, SettingsCustomizationRadarrRoute.route()),
        ),
        LSCardTile(
            title: LSTitle(text: 'Sonarr'),
            subtitle: LSSubtitle(text: 'Sonarr Customizations'),
            trailing: LSIconButton(icon: CustomIcons.television),
            onTap: () async => SettingsRouter.router.navigateTo(context, SettingsCustomizationSonarrRoute.route()),
        ),
        LSDivider(),
        LSCardTile(
            title: LSTitle(text: 'NZBGet'),
            subtitle: LSSubtitle(text: 'NZBGet Customizations'),
            trailing: LSIconButton(icon: CustomIcons.nzbget),
            onTap: () async => SettingsRouter.router.navigateTo(context, SettingsCustomizationNZBGetRoute.route()),
        ),
        LSCardTile(
            title: LSTitle(text: 'SABnzbd'),
            subtitle: LSSubtitle(text: 'SABnzbd Customizations'),
            trailing: LSIconButton(icon: CustomIcons.sabnzbd),
            onTap: () async => SettingsRouter.router.navigateTo(context, SettingsCustomizationSABnzbdRoute.route()),
        ),
        LSDivider(),
        LSCardTile(
            title: LSTitle(text: 'Tautulli'),
            subtitle: LSSubtitle(text: 'Tautulli Customizations'),
            trailing: LSIconButton(icon: CustomIcons.tautulli),
            onTap: () async => SettingsRouter.router.navigateTo(context, SettingsCustomizationTautulliRoute.route()),
        ),
    ];
}
