import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/overseerr.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:lunasea/modules/sonarr.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/modules/tautulli.dart';

class SettingsHeaderRoute extends StatefulWidget {
  final LunaModule module;

  const SettingsHeaderRoute({
    Key? key,
    required this.module,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SettingsHeaderRoute> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
      bottomNavigationBar: _bottomActionBar(),
    );
  }

  Widget _bottomActionBar() {
    return LunaBottomActionBar(
      actions: [
        LunaButton.text(
            text: 'settings.AddHeader'.tr(),
            icon: Icons.add_rounded,
            onTap: () async {
              await HeaderUtility().addHeader(context, headers: _headers());
              _resetState();
            }),
      ],
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'settings.CustomHeaders'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaBox.profiles.listenableBuilder(
      builder: (context, _) => LunaListView(
        controller: scrollController,
        children: [
          if ((_headers()).isEmpty) _noHeadersFound(),
          ..._headerList(),
        ],
      ),
    );
  }

  Widget _noHeadersFound() =>
      LunaMessage.inList(text: 'settings.NoHeadersAdded'.tr());

  List<LunaBlock> _headerList() {
    final headers = _headers();
    List<String> _sortedKeys = headers.keys.toList()..sort();
    return _sortedKeys
        .map<LunaBlock>((key) => _headerBlock(key, headers[key]))
        .toList();
  }

  LunaBlock _headerBlock(String key, String? value) {
    return LunaBlock(
      title: key,
      body: [TextSpan(text: value)],
      trailing: LunaIconButton(
          icon: LunaIcons.DELETE,
          color: LunaColours.red,
          onPressed: () async {
            await HeaderUtility().deleteHeader(
              context,
              key: key,
              headers: _headers(),
            );
            _resetState();
          }),
    );
  }

  Map<String, String> _headers() {
    switch (widget.module) {
      case LunaModule.DASHBOARD:
        throw Exception('Dashboard does not have a headers page');
      case LunaModule.EXTERNAL_MODULES:
        throw Exception('External modules do not have a headers page');
      case LunaModule.LIDARR:
        return LunaProfile.current.lidarrHeaders;
      case LunaModule.RADARR:
        return LunaProfile.current.radarrHeaders;
      case LunaModule.SONARR:
        return LunaProfile.current.sonarrHeaders;
      case LunaModule.SABNZBD:
        return LunaProfile.current.sabnzbdHeaders;
      case LunaModule.NZBGET:
        return LunaProfile.current.nzbgetHeaders;
      case LunaModule.SEARCH:
        throw Exception('Search does not have a headers page');
      case LunaModule.SETTINGS:
        throw Exception('Settings does not have a headers page');
      case LunaModule.WAKE_ON_LAN:
        throw Exception('Wake on LAN does not have a headers page');
      case LunaModule.OVERSEERR:
        return LunaProfile.current.overseerrHeaders;
      case LunaModule.TAUTULLI:
        return LunaProfile.current.tautulliHeaders;
    }
  }

  Future<void> _resetState() async {
    switch (widget.module) {
      case LunaModule.DASHBOARD:
        throw Exception('Dashboard does not have a global state');
      case LunaModule.EXTERNAL_MODULES:
        throw Exception('External modules do not have a global state');
      case LunaModule.LIDARR:
        return;
      case LunaModule.RADARR:
        return context.read<RadarrState>().reset();
      case LunaModule.SONARR:
        return context.read<SonarrState>().reset();
      case LunaModule.SABNZBD:
        return;
      case LunaModule.NZBGET:
        return;
      case LunaModule.SEARCH:
        throw Exception('Search does not have a global state');
      case LunaModule.SETTINGS:
        throw Exception('Settings does not have a global state');
      case LunaModule.WAKE_ON_LAN:
        throw Exception('Wake on LAN does not have a global state');
      case LunaModule.TAUTULLI:
        return context.read<TautulliState>().reset();
      case LunaModule.OVERSEERR:
        return context.read<OverseerrState>().reset();
    }
  }
}
