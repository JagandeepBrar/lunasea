import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class _SettingsConfigurationSearchAddHeadersArguments {
    final IndexerHiveObject indexer;

    _SettingsConfigurationSearchAddHeadersArguments({
        @required this.indexer,
    }) {
        assert(indexer != null);
    }
}

class SettingsConfigurationSearchAddHeadersRouter extends LunaPageRouter {
    SettingsConfigurationSearchAddHeadersRouter() : super('/settings/configuration/search/add/headers');

    @override
    Future<void> navigateTo(BuildContext context, {
        @required IndexerHiveObject indexer,
    }) => LunaRouter.router.navigateTo(
        context,
        route(),
        routeSettings: RouteSettings(arguments: _SettingsConfigurationSearchAddHeadersArguments(indexer: indexer)),
    );
    
    @override
    void defineRoute(FluroRouter router) => router.define(
        fullRoute,
        handler: Handler(handlerFunc: (context, params) => _SettingsConfigurationSearchAddHeadersRoute()),
        transitionType: LunaRouter.transitionType,
    );
}

class _SettingsConfigurationSearchAddHeadersRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationSearchAddHeadersRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationSearchAddHeadersRoute> with LunaScrollControllerMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    _SettingsConfigurationSearchAddHeadersArguments _arguments;

    @override
    Widget build(BuildContext context) {
        _arguments = ModalRoute.of(context).settings.arguments;
        if(_arguments == null || _arguments.indexer == null) return LunaInvalidRoute(title: 'Custom Headers', message: 'Indexer Not Found');
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar(),
            body: _body(),
        );
    }

    Widget _appBar() {
        return LunaAppBar(
            title: 'Custom Headers',
            scrollControllers: [scrollController],
        );
    }

    Widget _body() {
        return LunaListView(
            controller: scrollController,
            children: [
                if((_arguments.indexer.headers ?? {}).isEmpty) LunaMessage.inList(text: 'No Headers Added'),
                ..._list(),
                _addHeader(),
            ],
        );
    }

    List<Widget> _list() {
        Map<String, dynamic> headers = (_arguments.indexer.headers ?? {}).cast<String, dynamic>();
        List<String> _sortedKeys = headers.keys.toList()..sort();
        return _sortedKeys.map<LunaListTile>((key) => _headerTile(key, headers[key])).toList();
    }

    LunaListTile _headerTile(String key, String value) {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: key.toString()),
            subtitle: LunaText.subtitle(text: value.toString()),
            trailing: LunaIconButton(
                icon: Icons.delete,
                color: LunaColours.red,
                onPressed: () async {
                    await HeaderUtility().deleteHeader(context, headers: _arguments.indexer.headers, key: key);
                    if(mounted) setState(() {});
                }
            ),
        );
    }

    Widget _addHeader() {
        return LunaButtonContainer(
            children: [
                LunaButton(
                    text: 'Add Header',
                    onTap: () async {
                        await HeaderUtility().addHeader(context, headers: _arguments.indexer.headers);
                        if(mounted) setState(() {});
                    }
                ),
            ],
        );
    }
}
