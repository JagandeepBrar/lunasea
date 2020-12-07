import 'dart:io';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsResourcesRouter {
    static const ROUTE_NAME = '/settings/resources';

    static Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;
    
    static void defineRoutes(FluroRouter router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => _SettingsResourcesRoute()),
        transitionType: LunaRouter.transitionType,
    );

    SettingsResourcesRouter._();
}

class _SettingsResourcesRoute extends StatefulWidget {
    @override
    State<_SettingsResourcesRoute> createState() => _State();
}

class _State extends State<_SettingsResourcesRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Resources',
    );

    Widget get _body => LSListView(
        children: [
            LSCardTile(
                title: LSTitle(text: 'Discord'),
                subtitle: LSSubtitle(text: 'Chat & Discussions'),
                trailing: LSIconButton(icon: CustomIcons.discord),
                onTap: () async => await Constants.URL_DISCORD.lsLinks_OpenLink(),
            ),
            // LSCardTile(
            //     title: LSTitle(text: 'Documentation'),
            //     subtitle: LSSubtitle(text: 'View the Documentation'),
            //     trailing: LSIconButton(icon: CustomIcons.documentation),
            //     onTap: () async => await Constants.URL_DOCUMENTATION.lsLinks_OpenLink(),
            // ),
            LSCardTile(
                title: LSTitle(text: 'Feedback Board'),
                subtitle: LSSubtitle(text: 'Request New Features'),
                trailing: LSIconButton(icon: Icons.speaker_notes),
                onTap: () async => await Constants.URL_FEEDBACK.lsLinks_OpenLink(),
            ),
            LSCardTile(
                title: LSTitle(text: 'GitHub'),
                subtitle: LSSubtitle(text: 'View the Source Code'),
                trailing: LSIconButton(icon: CustomIcons.github),
                onTap: () async => await Constants.URL_GITHUB.lsLinks_OpenLink(),
            ),
            LSCardTile(
                title: LSTitle(text: 'Reddit'),
                subtitle: LSSubtitle(text: 'Ask Questions & Get Support'),
                trailing: LSIconButton(icon: CustomIcons.reddit),
                onTap: () async => await Constants.URL_REDDIT.lsLinks_OpenLink(),
            ),
            if(Platform.isIOS) LSCardTile(
                title: LSTitle(text: 'TestFlight'),
                subtitle: LSSubtitle(text: 'Join the TestFlight Beta'),
                trailing: LSIconButton(icon: Icons.developer_board),
                onTap: () async => await Constants.URL_TESTFLIGHT.lsLinks_OpenLink()
            ),
            LSCardTile(
                title: LSTitle(text: 'Website'),
                subtitle: LSSubtitle(text: 'Visit LunaSea\'s Website'),
                trailing: LSIconButton(icon: CustomIcons.home),
                onTap: () async => await Constants.URL_WEBSITE.lsLinks_OpenLink(),
            ),
        ],
    );
}
