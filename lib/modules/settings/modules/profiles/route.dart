import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsProfilesRouter extends LunaPageRouter {
    SettingsProfilesRouter() : super('/settings/profiles');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsProfilesRoute());
}

class _SettingsProfilesRoute extends StatefulWidget {
    @override
    State<_SettingsProfilesRoute> createState() => _State();
}

class _State extends State<_SettingsProfilesRoute> with AutomaticKeepAliveClientMixin {
    @override
    bool get wantKeepAlive => true;

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            appBar: _appBar,
            body: _body,
        );
    }

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Profiles',
    );

    Widget get _body => LSListView(
        children: [
            SettingsProfileEnabledTile(),
            SettingsProfileAddTile(),
            SettingsProfileRenameTile(),
            SettingsProfileDeleteTile(),
        ],
    );
}
