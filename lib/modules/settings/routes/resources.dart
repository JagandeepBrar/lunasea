import 'dart:io';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsResourcesRouter extends LunaPageRouter {
    SettingsResourcesRouter() : super('/settings/resources');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsResourcesRoute());
}

class _SettingsResourcesRoute extends StatefulWidget {
    @override
    State<_SettingsResourcesRoute> createState() => _State();
}

class _State extends State<_SettingsResourcesRoute> with LunaScrollControllerMixin {
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
            title: 'Resources',
            scrollControllers: [scrollController],
        );
    }

    Widget _body() {
        return LunaListView(
            controller: scrollController,
            children: [
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Discord'),
                    subtitle: LunaText.subtitle(text: 'Chat & Discussions'),
                    trailing: LunaIconButton(icon: CustomIcons.discord),
                    onTap: () async => await Constants.URL_DISCORD.lunaOpenGenericLink(),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Documentation'),
                    subtitle: LunaText.subtitle(text: 'View the Documentation'),
                    trailing: LunaIconButton(icon: CustomIcons.documentation),
                    onTap: () async => await Constants.URL_DOCUMENTATION.lunaOpenGenericLink(),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Feedback Board'),
                    subtitle: LunaText.subtitle(text: 'Request New Features'),
                    trailing: LunaIconButton(icon: Icons.speaker_notes),
                    onTap: () async => await Constants.URL_FEEDBACK.lunaOpenGenericLink(),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'GitHub'),
                    subtitle: LunaText.subtitle(text: 'View the Source Code'),
                    trailing: LunaIconButton(icon: CustomIcons.github),
                    onTap: () async => await Constants.URL_GITHUB.lunaOpenGenericLink(),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Reddit'),
                    subtitle: LunaText.subtitle(text: 'Ask Questions & Get Support'),
                    trailing: LunaIconButton(icon: CustomIcons.reddit),
                    onTap: () async => await Constants.URL_REDDIT.lunaOpenGenericLink(),
                ),
                if(Platform.isIOS) LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'TestFlight'),
                    subtitle: LunaText.subtitle(text: 'Join the TestFlight Beta'),
                    trailing: LunaIconButton(icon: Icons.developer_board),
                    onTap: () async => await Constants.URL_TESTFLIGHT.lunaOpenGenericLink()
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Website'),
                    subtitle: LunaText.subtitle(text: 'Visit LunaSea\'s Website'),
                    trailing: LunaIconButton(icon: CustomIcons.home),
                    onTap: () async => await Constants.URL_WEBSITE.lunaOpenGenericLink(),
                ),
            ],
        );
    }
}
