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
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'settings.Resources'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        LunaBlock(
          title: 'Discord',
          body: [TextSpan(text: 'settings.DiscordDescription'.tr())],
          trailing: const LunaIconButton(icon: LunaBrandIcons.discord),
          onTap: LunaLinks.DISCORD.launch,
        ),
        LunaBlock(
          title: 'settings.Documentation'.tr(),
          body: [TextSpan(text: 'settings.DocumentationDescription'.tr())],
          trailing: const LunaIconButton(icon: Icons.auto_stories_rounded),
          onTap: LunaLinks.DOCUMENTATION.launch,
        ),
        LunaBlock(
          title: 'settings.FeedbackBoard'.tr(),
          body: [TextSpan(text: 'settings.FeedbackBoardDescription'.tr())],
          trailing: const LunaIconButton(icon: Icons.speaker_notes_rounded),
          onTap: LunaLinks.FEEDBACK_BOARD.launch,
        ),
        LunaBlock(
          title: 'GitHub',
          body: [TextSpan(text: 'settings.GitHubDescription'.tr())],
          trailing: const LunaIconButton(icon: LunaBrandIcons.github),
          onTap: LunaLinks.GITHUB.launch,
        ),
        LunaBlock(
          title: 'Reddit',
          body: [TextSpan(text: 'settings.RedditDescription'.tr())],
          trailing: const LunaIconButton(icon: LunaBrandIcons.reddit),
          onTap: LunaLinks.REDDIT.launch,
        ),
        LunaBlock(
          title: 'settings.TestBuilds'.tr(),
          body: [TextSpan(text: 'settings.TestBuildsDescription'.tr())],
          trailing: const LunaIconButton(icon: Icons.developer_board_rounded),
          onTap: LunaLinks.TEST_BUILDS.launch,
        ),
        LunaBlock(
          title: 'settings.SystemStatus'.tr(),
          body: [TextSpan(text: 'settings.SystemStatusDescription'.tr())],
          trailing: const LunaIconButton(icon: Icons.health_and_safety),
          onTap: LunaLinks.SYSTEM_STATUS.launch,
        ),
        LunaBlock(
          title: 'Weblate',
          body: [TextSpan(text: 'settings.WeblateDescription'.tr())],
          trailing: const LunaIconButton(icon: LunaIcons.TRANSLATE),
          onTap: LunaLinks.WEBLATE.launch,
        ),
        LunaBlock(
          title: 'settings.Website'.tr(),
          body: [TextSpan(text: 'settings.WebsiteDescription'.tr())],
          trailing: const LunaIconButton(icon: LunaIcons.HOME),
          onTap: LunaLinks.WEBSITE.launch,
        ),
      ],
    );
  }
}
