import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsHeaderRoute extends StatefulWidget {
    final LunaModule module;

    SettingsHeaderRoute({
        Key key,
        @required this.module,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SettingsHeaderRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
        if(widget.module == null) return LunaInvalidRoute(title: 'Custom Headers', message: 'Unknown Module');
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar(),
            body: _body(),
        );
    }

    Widget _appBar() {
        return LunaAppBar(
            title: 'Custom Headers',
            state: context.read<SettingsState>(),
        );
    }

    Widget _body() {
        return ValueListenableBuilder(
            valueListenable: Database.profilesBox.listenable(),
            builder: (context, profile, _) => LunaListView(
                scrollController: context.read<SettingsState>().scrollController,
                children: [
                    if((_headers() ?? {}).isEmpty) _noHeadersFound(),
                    ..._headerList(),
                    _addHeader(),
                ],
            ),
        );
    }

    Widget _noHeadersFound() => LunaMessage.inList(text: 'No Headers Added');

    List<LunaListTile> _headerList() {
        Map<String, dynamic> headers = (_headers() ?? {}).cast<String, dynamic>();
        List<String> _sortedKeys = headers.keys.toList()..sort();
        return _sortedKeys.map<LunaListTile>((key) => _headerTile(key, headers[key])).toList();
    }

    LunaListTile _headerTile(String key, String value) {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: key),
            subtitle: LunaText.subtitle(text: value),
            trailing: LunaIconButton(
                icon: Icons.delete,
                color: LunaColours.red,
                onPressed: () async => HeaderUtility().deleteHeader(context, headers: _headers(), key: key),
            ),
        );
    }

    Widget _addHeader() {
        return LunaButtonContainer(
            children: [
                LunaButton(
                    text: 'Add Header',
                    onTap: () async => HeaderUtility().addHeader(context, headers: _headers()),
                ),
            ],
        );
    }

    Map<dynamic, dynamic> _headers() {
        switch(widget.module) {
            case LunaModule.LIDARR: return Database.currentProfileObject.lidarrHeaders;
            case LunaModule.RADARR: return Database.currentProfileObject.radarrHeaders;
            case LunaModule.SONARR: return Database.currentProfileObject.sonarrHeaders;
            case LunaModule.SABNZBD: return Database.currentProfileObject.sabnzbdHeaders;
            case LunaModule.NZBGET: return Database.currentProfileObject.nzbgetHeaders;
            case LunaModule.SEARCH: throw Exception('Search does not have a headers page');
            case LunaModule.SETTINGS: throw Exception('Settings does not have a headers page');
            case LunaModule.WAKE_ON_LAN: throw Exception('Wake on LAN does not have a headers page');
            case LunaModule.TAUTULLI: return Database.currentProfileObject.tautulliHeaders;
        }
        return {};
    }
}
