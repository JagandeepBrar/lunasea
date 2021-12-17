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
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        LunaModule.RADARR.informationBanner(),
        _enabledToggle(),
        _connectionDetailsPage(),
        const LunaDivider(),
        _defaultPagesPage(),
        _defaultSortingFilteringPage(),
        _discoverUseRadarrSuggestionsToggle(),
        _queueSize(),
      ],
    );
  }

  Widget _enabledToggle() {
    return ValueListenableBuilder(
      valueListenable: Database.profilesBox.listenable(),
      builder: (context, _, __) => LunaBlock(
        title: 'Enable ${LunaModule.RADARR.name}',
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
    return LunaBlock(
      title: 'Connection Details',
      body: const [TextSpan(text: 'Connection Details for Radarr')],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => SettingsConfigurationRadarrConnectionDetailsRouter()
          .navigateTo(context),
    );
  }

  Widget _defaultPagesPage() {
    return LunaBlock(
      title: 'Default Pages',
      body: const [TextSpan(text: 'Set Default Landing Pages')],
      trailing: const LunaIconButton.arrow(),
      onTap: () async =>
          SettingsConfigurationRadarrDefaultPagesRouter().navigateTo(context),
    );
  }

  Widget _defaultSortingFilteringPage() {
    return LunaBlock(
      title: 'Default Sorting & Filtering',
      body: const [TextSpan(text: 'Set Default Sorting & Filtering Methods')],
      trailing: const LunaIconButton.arrow(),
      onTap: () async =>
          SettingsConfigurationRadarrDefaultSortingRouter().navigateTo(context),
    );
  }

  Widget _discoverUseRadarrSuggestionsToggle() {
    RadarrDatabaseValue _db = RadarrDatabaseValue.ADD_DISCOVER_USE_SUGGESTIONS;
    return _db.listen(
      builder: (context, _, __) => LunaBlock(
        title: 'Discover Suggestions',
        body: const [TextSpan(text: 'Add Suggested Releases in Discover')],
        trailing: LunaSwitch(
          value: _db.data,
          onChanged: (value) => _db.put(value),
        ),
      ),
    );
  }

  Widget _queueSize() {
    RadarrDatabaseValue _db = RadarrDatabaseValue.QUEUE_PAGE_SIZE;
    return _db.listen(
      builder: (context, _, __) => LunaBlock(
        title: 'Queue Size',
        body: [TextSpan(text: _db.data == 1 ? '1 Item' : '${_db.data} Items')],
        trailing: const LunaIconButton(icon: Icons.queue_rounded),
        onTap: () async {
          Tuple2<bool, int> result =
              await RadarrDialogs().setQueuePageSize(context);
          if (result.item1) _db.put(result.item2);
        },
      ),
    );
  }
}
