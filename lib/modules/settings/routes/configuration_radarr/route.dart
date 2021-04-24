import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationRadarrRouter extends SettingsPageRouter {
  SettingsConfigurationRadarrRouter() : super('/settings/configuration/radarr');

  @override
  Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) {
    super.noParameterRouteDefinition(router);
  }
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
      title: 'Radarr',
      scrollControllers: [scrollController],
      actions: [
        LunaIconButton(
          icon: Icons.help_outline,
          onPressed: () async =>
              SettingsDialogs().moduleInformation(context, LunaModule.RADARR),
        ),
      ],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        _enabledToggle(),
        _connectionDetailsPage(),
        LunaDivider(),
        _defaultPagesPage(),
        _defaultSortingFilteringPage(),
        _discoverUseRadarrSuggestionsToggle(),
        _queuePageSize(),
      ],
    );
  }

  Widget _enabledToggle() {
    return ValueListenableBuilder(
      valueListenable: Database.profilesBox.listenable(),
      builder: (context, _, __) => LunaListTile(
        context: context,
        title: LunaText.title(text: 'Enable ${LunaModule.RADARR.name}'),
        trailing: LunaSwitch(
          value: Database.currentProfileObject.radarrEnabled ?? false,
          onChanged: (value) {
            Database.currentProfileObject.radarrEnabled = value;
            Database.currentProfileObject.save();
            context.read<RadarrState>().reset();
          },
        ),
      ),
    );
  }

  Widget _connectionDetailsPage() {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'Connection Details'),
      subtitle: LunaText.subtitle(text: 'Connection Details for Radarr'),
      trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
      onTap: () async => SettingsConfigurationRadarrConnectionDetailsRouter()
          .navigateTo(context),
    );
  }

  Widget _defaultPagesPage() {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'Default Pages'),
      subtitle: LunaText.subtitle(text: 'Set Default Landing Pages'),
      trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
      onTap: () async =>
          SettingsConfigurationRadarrDefaultPagesRouter().navigateTo(context),
    );
  }

  Widget _defaultSortingFilteringPage() {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'Default Sorting & Filtering'),
      subtitle:
          LunaText.subtitle(text: 'Set Default Sorting & Filtering Methods'),
      trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
      onTap: () async =>
          SettingsConfigurationRadarrDefaultSortingRouter().navigateTo(context),
    );
  }

  Widget _discoverUseRadarrSuggestionsToggle() {
    return RadarrDatabaseValue.ADD_DISCOVER_USE_SUGGESTIONS.listen(
      builder: (context, _, __) => LunaListTile(
        context: context,
        title: LunaText.title(text: 'Discover Suggestions'),
        subtitle: LunaText.subtitle(text: 'Add Suggested Releases in Discover'),
        trailing: LunaSwitch(
          value: RadarrDatabaseValue.ADD_DISCOVER_USE_SUGGESTIONS.data,
          onChanged: (value) =>
              RadarrDatabaseValue.ADD_DISCOVER_USE_SUGGESTIONS.put(value),
        ),
      ),
    );
  }

  Widget _queuePageSize() {
    return RadarrDatabaseValue.QUEUE_PAGE_SIZE.listen(
      builder: (context, _, __) => LunaListTile(
        context: context,
        title: LunaText.title(text: 'Queue Page Size'),
        subtitle: LunaText.subtitle(
          text: RadarrDatabaseValue.QUEUE_PAGE_SIZE.data == 1
              ? '1 Item'
              : '${RadarrDatabaseValue.QUEUE_PAGE_SIZE.data} Items',
        ),
        trailing: LunaIconButton(icon: LunaIcons.queue),
        onTap: () async {
          Tuple2<bool, int> result =
              await RadarrDialogs().setQueuePageSize(context);
          if (result.item1)
            RadarrDatabaseValue.QUEUE_PAGE_SIZE.put(result.item2);
        },
      ),
    );
  }
}
