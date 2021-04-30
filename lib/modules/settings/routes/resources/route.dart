import 'dart:io';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsResourcesRouter extends SettingsPageRouter {
  SettingsResourcesRouter() : super('/settings/resources');

  @override
  _Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) =>
      super.noParameterRouteDefinition(router);
}

class _Widget extends StatefulWidget {
  @override
  State<_Widget> createState() => _State();
}

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
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
          trailing: LunaIconButton(icon: LunaIcons.discord),
          onTap: LunaLinks.DISCORD.launch,
        ),
        LunaListTile(
          context: context,
          title: LunaText.title(text: 'Documentation'),
          subtitle: LunaText.subtitle(text: 'View the Documentation'),
          trailing: LunaIconButton(icon: LunaIcons.documentation),
          onTap: LunaLinks.DOCUMENTATION.launch,
        ),
        LunaListTile(
          context: context,
          title: LunaText.title(text: 'Feedback Board'),
          subtitle: LunaText.subtitle(text: 'Request New Features'),
          trailing: LunaIconButton(icon: Icons.speaker_notes),
          onTap: LunaLinks.FEEDBACK_BOARD.launch,
        ),
        LunaListTile(
          context: context,
          title: LunaText.title(text: 'GitHub'),
          subtitle: LunaText.subtitle(text: 'View the Source Code'),
          trailing: LunaIconButton(icon: LunaIcons.github),
          onTap: LunaLinks.GITHUB.launch,
        ),
        LunaListTile(
          context: context,
          title: LunaText.title(text: 'Reddit'),
          subtitle: LunaText.subtitle(text: 'Ask Questions & Get Support'),
          trailing: LunaIconButton(icon: LunaIcons.reddit),
          onTap: LunaLinks.REDDIT.launch,
        ),
        if (Platform.isIOS)
          LunaListTile(
              context: context,
              title: LunaText.title(text: 'TestFlight'),
              subtitle: LunaText.subtitle(text: 'Join the TestFlight Beta'),
              trailing: LunaIconButton(icon: Icons.developer_board),
              onTap: LunaLinks.TESTFLIGHT.launch),
        LunaListTile(
            context: context,
            title: LunaText.title(text: 'System Status'),
            subtitle:
                LunaText.subtitle(text: 'Status Page for Hosted Services'),
            trailing: LunaIconButton(icon: LunaIcons.monitoring),
            onTap: LunaLinks.SYSTEM_STATUS.launch),
        LunaListTile(
          context: context,
          title: LunaText.title(text: 'Weblate'),
          subtitle: LunaText.subtitle(text: 'Help Localize LunaSea'),
          trailing: LunaIconButton(icon: Icons.translate),
          onTap: LunaLinks.WEBLATE.launch,
        ),
        LunaListTile(
          context: context,
          title: LunaText.title(text: 'Website'),
          subtitle: LunaText.subtitle(text: 'Visit LunaSea\'s Website'),
          trailing: LunaIconButton(icon: LunaIcons.home),
          onTap: LunaLinks.WEBSITE.launch,
        ),
      ],
    );
  }
}
