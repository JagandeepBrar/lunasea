import 'dart:io';
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
        LunaBlock(
          title: 'Discord',
          body: const [TextSpan(text: 'Chat & Discussions')],
          trailing: const LunaIconButton(icon: LunaBrandIcons.discord),
          onTap: LunaLinks.DISCORD.launch,
        ),
        LunaBlock(
          title: 'Documentation',
          body: const [TextSpan(text: 'View the Documentation')],
          trailing: const LunaIconButton(icon: Icons.auto_stories_rounded),
          onTap: LunaLinks.DOCUMENTATION.launch,
        ),
        LunaBlock(
          title: 'Feedback Board',
          body: const [TextSpan(text: 'Request New Features')],
          trailing: const LunaIconButton(icon: Icons.speaker_notes_rounded),
          onTap: LunaLinks.FEEDBACK_BOARD.launch,
        ),
        LunaBlock(
          title: 'GitHub',
          body: const [TextSpan(text: 'View the Source Code')],
          trailing: const LunaIconButton(icon: LunaBrandIcons.github),
          onTap: LunaLinks.GITHUB.launch,
        ),
        LunaBlock(
          title: 'Reddit',
          body: const [TextSpan(text: 'Ask Questions & Get Support')],
          trailing: const LunaIconButton(icon: LunaBrandIcons.reddit),
          onTap: LunaLinks.REDDIT.launch,
        ),
        if (Platform.isIOS)
          LunaBlock(
            title: 'TestFlight',
            body: const [TextSpan(text: 'Join the TestFlight Beta')],
            trailing: const LunaIconButton(icon: Icons.developer_board_rounded),
            onTap: LunaLinks.TESTFLIGHT.launch,
          ),
        LunaBlock(
          title: 'System Status',
          body: const [TextSpan(text: 'Status Page for Hosted Services')],
          trailing: const LunaIconButton(icon: Icons.health_and_safety),
          onTap: LunaLinks.SYSTEM_STATUS.launch,
        ),
        LunaBlock(
          title: 'Weblate',
          body: const [TextSpan(text: 'Help Localize LunaSea')],
          trailing: const LunaIconButton(icon: LunaIcons.TRANSLATE),
          onTap: LunaLinks.WEBLATE.launch,
        ),
        LunaBlock(
          title: 'Website',
          body: const [TextSpan(text: 'Visit LunaSea\'s Website')],
          trailing: const LunaIconButton(icon: LunaIcons.HOME),
          onTap: LunaLinks.WEBSITE.launch,
        ),
      ],
    );
  }
}
