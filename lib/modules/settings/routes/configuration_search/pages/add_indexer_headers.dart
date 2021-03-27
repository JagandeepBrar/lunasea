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

class SettingsConfigurationSearchAddHeadersRouter extends SettingsPageRouter {
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
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationSearchAddHeadersRoute());
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
            bottomNavigationBar: _bottomActionBar(),
        );
    }

    Widget _appBar() {
        return LunaAppBar(
            title: 'Custom Headers',
            scrollControllers: [scrollController],
        );
    }

    Widget _bottomActionBar() {
        return LunaBottomActionBar(
            actions: [
                LunaButton.text(
                    text: 'Add Header',
                    icon: Icons.add_rounded,
                    onTap: () async {
                        await HeaderUtility().addHeader(context, headers: _arguments.indexer.headers);
                        if(mounted) setState(() {});
                    }
                ),
            ],
        );
    }

    Widget _body() {
        return LunaListView(
            controller: scrollController,
            children: [
                if((_arguments.indexer.headers ?? {}).isEmpty) LunaMessage.inList(text: 'No Headers Added'),
                ..._list(),
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
}
