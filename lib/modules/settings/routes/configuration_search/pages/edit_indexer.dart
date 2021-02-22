import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationSearchEditRouter extends LunaPageRouter {
    SettingsConfigurationSearchEditRouter() : super('/settings/configuration/search/edit/:indexerid');

    @override
    Future<void> navigateTo(BuildContext context, { @required int indexerId }) async => LunaRouter.router.navigateTo(context, route(indexerId: indexerId));

    @override
    String route({ @required int indexerId }) => super.fullRoute.replaceFirst(':indexerid', indexerId?.toString() ?? -1);
    
    @override
    void defineRoute(FluroRouter router) => router.define(
        super.fullRoute,
        handler: Handler(handlerFunc: (context, params) {
            int indexerId = params['indexerid'] == null || params['indexerid'].length == 0 ? -1 : (int.tryParse(params['indexerid'][0]) ?? -1);
            return _SettingsConfigurationSearchEditRoute(indexerId: indexerId);
        }),
        transitionType: LunaRouter.transitionType,
    );
}

class _SettingsConfigurationSearchEditRoute extends StatefulWidget {
    final int indexerId;

    _SettingsConfigurationSearchEditRoute({
        Key key,
        @required this.indexerId,
    }) : super(key: key);

    @override
    State<_SettingsConfigurationSearchEditRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationSearchEditRoute> with LunaScrollControllerMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    IndexerHiveObject _indexer;

    @override
    Widget build(BuildContext context) {
        if(widget.indexerId < 0) return LunaInvalidRoute(title: 'Edit Indexer', message: 'Indexer Not Found');
        if(!Database.indexersBox.containsKey(widget.indexerId)) return LunaInvalidRoute(title: 'Edit Indexer', message: 'Indexer Not Found');
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar(),
            body: _body(),
        );
    }

    Widget _appBar() {
        return LunaAppBar(
            title: 'Edit Indexer',
            scrollControllers: [scrollController],
        );
    }

    Widget _body() {
        return ValueListenableBuilder(
            valueListenable: Database.indexersBox.listenable(keys: [widget.indexerId]),
            builder: (context, box, __) {
                if(!Database.indexersBox.containsKey(widget.indexerId)) return Container();
                _indexer = Database.indexersBox.get(widget.indexerId);
                return LunaListView(
                    controller: scrollController,
                    children: [
                        _displayName(),
                        _apiURL(),
                        _apiKey(),
                        _headers(),
                        _deleteIndexer(),
                    ],
                );
            }
        );
    }

    Widget _displayName() {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Display Name'),
            subtitle: LunaText.subtitle(text: _indexer.displayName == null || _indexer.displayName.isEmpty ? 'Not Set' : _indexer.displayName),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async {
                Tuple2<bool, String> values = await LunaDialogs().editText(context, 'Display Name', prefill: _indexer.displayName);
                if(values.item1) _indexer.displayName = values.item2;
                _indexer.save();
            },
        );
    }

    Widget _apiURL() {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Indexer API Host'),
            subtitle: LunaText.subtitle(text: _indexer.host == null || _indexer.host.isEmpty ? 'Not Set' : _indexer.host),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async {
                Tuple2<bool, String> values = await LunaDialogs().editText(context, 'Indexer API Host', prefill: _indexer.host);
                if(values.item1) _indexer.host = values.item2;
                _indexer.save();
            },
        );
    }

    Widget _apiKey() {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Indexer API Key'),
            subtitle: LunaText.subtitle(text: _indexer.apiKey == null || _indexer.apiKey.isEmpty ? 'Not Set' : _indexer.apiKey),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async {
                Tuple2<bool, String> values = await LunaDialogs().editText(context, 'Indexer API Key', prefill: _indexer.apiKey);
                if(values.item1) _indexer.apiKey = values.item2;
                _indexer.save();
            },
        );
    }

    Widget _headers() {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Custom Headers'),
            subtitle: LunaText.subtitle(text: 'Add Custom Headers to Requests'),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async => SettingsConfigurationSearchEditHeadersRouter().navigateTo(context, indexerId: widget.indexerId),
        );
    }

    Widget _deleteIndexer() {
        return LunaButtonContainer(
            children: [
                LunaButton(
                    text: 'Delete Indexer',
                    backgroundColor: LunaColours.red,
                    onTap: () async {
                        List _values = await SettingsDialogs.deleteIndexer(context);
                        if(_values[0]) {
                            showLunaSuccessSnackBar(title: 'Indexer Deleted', message: _indexer.displayName);
                            _indexer.delete();
                            Navigator.of(context).pop();
                        }
                    },
                ),
            ],
        );
    }
}
