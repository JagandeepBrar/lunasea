import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationRadarrHeadersRouter extends LunaPageRouter {
    SettingsConfigurationRadarrHeadersRouter() : super('/settings/configuration/radarr/headers');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationRadarrHeadersRoute());
}

class _SettingsConfigurationRadarrHeadersRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationRadarrHeadersRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationRadarrHeadersRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Custom Headers',
    );

    Widget get _body => ValueListenableBuilder(
        valueListenable: Database.profilesBox.listenable(),
        builder: (context, profile, _) => LSListView(
            children: _headers,
        ),
    );

    List<Widget> get _headers => [
        if((Database.currentProfileObject.radarrHeaders ?? {}).isEmpty) _noHeaders,
        ..._list,
        SettingsModulesRadarrHeadersAddHeaderTile(),
    ];

    Widget get _noHeaders => LSGenericMessage(text: 'No Custom Headers Added');

    List<Widget> get _list {
        Map<String, dynamic> headers = (Database.currentProfileObject.radarrHeaders ?? {}).cast<String, dynamic>();
        List<SettingsModulesRadarrHeadersHeaderTile> list = [];
        headers.forEach((key, value) => list.add(SettingsModulesRadarrHeadersHeaderTile(
            headerKey: key.toString(),
            headerValue: value.toString(),
        )));
        list.sort((a,b) => a.headerKey.toLowerCase().compareTo(b.headerKey.toLowerCase()));
        return list;
    }
}
