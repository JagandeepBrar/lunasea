import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationSearchAddRouter extends SettingsPageRouter {
    SettingsConfigurationSearchAddRouter() : super('/settings/configuration/search/add');

    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationSearchAddRoute());
}

class _SettingsConfigurationSearchAddRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationSearchAddRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationSearchAddRoute> with LunaScrollControllerMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    IndexerHiveObject _indexer = IndexerHiveObject.empty();

    @override
    Widget build(BuildContext context) {
        return  LunaScaffold(
            scaffoldKey: _scaffoldKey,
            appBar: _appBar(),
            body: _body(),
            bottomNavigationBar: _bottomActionBar(),
        );
    }

    Widget _appBar() {
        return LunaAppBar(
            title: 'Add Indexer',
            scrollControllers: [scrollController],
        );
    }

    Widget _bottomActionBar() {
        return LunaBottomActionBar(
            actions: [
                LunaButton.text(
                    text: 'Add Indexer',
                    icon: Icons.add_rounded,
                    onTap: () async {
                        if(_indexer.displayName.isEmpty || _indexer.host.isEmpty || _indexer.apiKey.isEmpty) {
                            showLunaErrorSnackBar(
                                title: 'Failed to Add Indexer',
                                message: 'All fields are required',
                            );
                        } else {
                            Database.indexersBox.add(_indexer);
                            showLunaSuccessSnackBar(
                                title: 'Indexer Added',
                                message: _indexer.displayName,
                            );
                            Navigator.of(context).pop();
                        }
                    },
                ),
            ],
        );
    }

    Widget _body() {
        return LunaListView(
            controller: scrollController,
            children: [
                _displayName(),
                _apiURL(),
                _apiKey(),
                _headers(),
            ],
        );
    }

    Widget _displayName() {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Display Name'),
            subtitle: LunaText.subtitle(text: _indexer.displayName == null || _indexer.displayName.isEmpty ? 'Not Set' : _indexer.displayName),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
            onTap: () async {
                Tuple2<bool, String> values = await LunaDialogs().editText(context, 'Display Name', prefill: _indexer.displayName);
                if(values.item1 && mounted) setState(() => _indexer.displayName = values.item2);
            },
        );
    }

    Widget _apiURL() {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Indexer API Host'),
            subtitle: LunaText.subtitle(text: _indexer.host == null || _indexer.host.isEmpty ? 'Not Set' : _indexer.host),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
            onTap: () async {
                Tuple2<bool, String> values = await LunaDialogs().editText(context, 'Indexer API Host', prefill: _indexer.host);
                if(values.item1 && mounted) setState(() => _indexer.host = values.item2);
            },
        );
    }
    
    Widget _apiKey() {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Indexer API Key'),
            subtitle: LunaText.subtitle(text: _indexer.apiKey == null || _indexer.apiKey.isEmpty ? 'Not Set' : _indexer.apiKey),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
            onTap: () async {
                Tuple2<bool, String> values = await LunaDialogs().editText(context, 'Indexer API Key', prefill: _indexer.apiKey);
                if(values.item1 && mounted) setState(() => _indexer.apiKey = values.item2);
            },
        );
    }

    Widget _headers() {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Custom Headers'),
            subtitle: LunaText.subtitle(text: 'Add Custom Headers to Requests'),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
            onTap: () async => SettingsConfigurationSearchAddHeadersRouter().navigateTo(context, indexer: _indexer),
        );
    }
}
