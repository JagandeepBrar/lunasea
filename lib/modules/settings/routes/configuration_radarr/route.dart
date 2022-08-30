import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:lunasea/router/routes/settings.dart';

class ConfigurationRadarrRoute extends StatefulWidget {
  const ConfigurationRadarrRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationRadarrRoute> createState() => _State();
}

class _State extends State<ConfigurationRadarrRoute>
    with LunaScrollControllerMixin {
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
        LunaDivider(),
        _defaultOptionsPage(),
        _defaultPagesPage(),
        _discoverUseRadarrSuggestionsToggle(),
        _queueSize(),
      ],
    );
  }

  Widget _enabledToggle() {
    return LunaBox.profiles.watch(
      builder: (context, _) => LunaBlock(
        title: 'Enable ${LunaModule.RADARR.title}',
        trailing: LunaSwitch(
          value: LunaProfile.current.radarrEnabled,
          onChanged: (value) {
            LunaProfile.current.radarrEnabled = value;
            LunaProfile.current.save();
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
      onTap: SettingsRoutes.CONFIGURATION_RADARR_CONNECTION_DETAILS.go,
    );
  }

  Widget _defaultOptionsPage() {
    return LunaBlock(
      title: 'settings.DefaultOptions'.tr(),
      body: [TextSpan(text: 'settings.DefaultOptionsDescription'.tr())],
      trailing: const LunaIconButton.arrow(),
      onTap: SettingsRoutes.CONFIGURATION_RADARR_DEFAULT_OPTIONS.go,
    );
  }

  Widget _defaultPagesPage() {
    return LunaBlock(
      title: 'Default Pages',
      body: const [TextSpan(text: 'Set Default Landing Pages')],
      trailing: const LunaIconButton.arrow(),
      onTap: SettingsRoutes.CONFIGURATION_RADARR_DEFAULT_PAGES.go,
    );
  }

  Widget _discoverUseRadarrSuggestionsToggle() {
    const _db = RadarrDatabase.ADD_DISCOVER_USE_SUGGESTIONS;
    return _db.watch(
      builder: (context, _) => LunaBlock(
        title: 'Discover Suggestions',
        body: const [TextSpan(text: 'Add Suggested Releases in Discover')],
        trailing: LunaSwitch(
          value: _db.read(),
          onChanged: (value) => _db.update(value),
        ),
      ),
    );
  }

  Widget _queueSize() {
    const _db = RadarrDatabase.QUEUE_PAGE_SIZE;
    return _db.watch(
      builder: (context, _) => LunaBlock(
        title: 'Queue Size',
        body: [
          TextSpan(text: _db.read() == 1 ? '1 Item' : '${_db.read()} Items')
        ],
        trailing: const LunaIconButton(icon: Icons.queue_play_next_rounded),
        onTap: () async {
          Tuple2<bool, int> result =
              await RadarrDialogs().setQueuePageSize(context);
          if (result.item1) _db.update(result.item2);
        },
      ),
    );
  }
}
