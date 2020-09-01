import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsCustomizationRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/customization';

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
            onTap: () async => Navigator.of(context).pushNamed(SettingsCustomizationAppearanceRoute.ROUTE_NAME),
        ),
        LSCardTile(
            title: LSTitle(text: 'Drawer'),
            subtitle: LSSubtitle(text: 'Drawer Customizations'),
            trailing: LSIconButton(icon: Icons.dehaze),
            onTap: () async => Navigator.of(context).pushNamed(SettingsCustomizationDrawerRoute.ROUTE_NAME),
        ),
        if(Platform.isIOS) SettingsCustomizationBrowserTile(),
        LSCardTile(
            title: LSTitle(text: 'Quick Actions'),
            subtitle: LSSubtitle(text: 'Quick Actions on the Home Screen'),
            trailing: LSIconButton(icon: Icons.rounded_corner),
            onTap: () async => Navigator.of(context).pushNamed(SettingsCustomizationQuickActionsRoute.ROUTE_NAME),
        ),
    ];

    List<Widget> get _modules => [
        LSCardTile(
            title: LSTitle(text: 'Calendar'),
            subtitle: LSSubtitle(text: 'Calendar Customizations'),
            trailing: LSIconButton(icon: CustomIcons.calendar),
            onTap: () async => Navigator.of(context).pushNamed(SettingsCustomizationCalendarRoute.ROUTE_NAME),
        ),
        LSCardTile(
            title: LSTitle(text: 'Home'),
            subtitle: LSSubtitle(text: 'Home Customizations'),
            trailing: LSIconButton(icon: CustomIcons.home),
            onTap: () async => Navigator.of(context).pushNamed(SettingsCustomizationHomeRoute.ROUTE_NAME),
        ),
        LSCardTile(
            title: LSTitle(text: 'Search'),
            subtitle: LSSubtitle(text: 'Search Customizations'),
            trailing: LSIconButton(icon: Icons.search),
            onTap: () async => Navigator.of(context).pushNamed(SettingsCustomizationSearchRoute.ROUTE_NAME),
        ),
        LSDivider(),
        LSCardTile(
            title: LSTitle(text: 'Lidarr'),
            subtitle: LSSubtitle(text: 'Lidarr Customizations'),
            trailing: LSIconButton(icon: CustomIcons.music),
            onTap: () async => Navigator.of(context).pushNamed(SettingsCustomizationLidarrRoute.ROUTE_NAME),
        ),
        LSCardTile(
            title: LSTitle(text: 'Radarr'),
            subtitle: LSSubtitle(text: 'Radarr Customizations'),
            trailing: LSIconButton(icon: CustomIcons.movies),
            onTap: () async => Navigator.of(context).pushNamed(SettingsCustomizationRadarrRoute.ROUTE_NAME),
        ),
        LSCardTile(
            title: LSTitle(text: 'Sonarr'),
            subtitle: LSSubtitle(text: 'Sonarr Customizations'),
            trailing: LSIconButton(icon: CustomIcons.television),
            onTap: () async => Navigator.of(context).pushNamed(SettingsCustomizationSonarrRoute.ROUTE_NAME),
        ),
        LSDivider(),
        LSCardTile(
            title: LSTitle(text: 'NZBGet'),
            subtitle: LSSubtitle(text: 'NZBGet Customizations'),
            trailing: LSIconButton(icon: CustomIcons.nzbget),
            onTap: () async => Navigator.of(context).pushNamed(SettingsCustomizationNZBGetRoute.ROUTE_NAME),
        ),
        LSCardTile(
            title: LSTitle(text: 'SABnzbd'),
            subtitle: LSSubtitle(text: 'SABnzbd Customizations'),
            trailing: LSIconButton(icon: CustomIcons.sabnzbd),
            onTap: () async => Navigator.of(context).pushNamed(SettingsCustomizationSABnzbdRoute.ROUTE_NAME),
        ),
        LSDivider(),
        LSCardTile(
            title: LSTitle(text: 'Tautulli'),
            subtitle: LSSubtitle(text: 'Tautulli Customizations'),
            trailing: LSIconButton(icon: CustomIcons.tautulli),
            onTap: () async => Navigator.of(context).pushNamed(SettingsCustomizationTautulliRoute.ROUTE_NAME),
        ),
    ];
}
