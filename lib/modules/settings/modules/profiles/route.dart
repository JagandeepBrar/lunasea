import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsProfilesRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/profiles';

    SettingsProfilesRoute({
        Key key,
    }): super(key: key);

    @override
    State<SettingsProfilesRoute> createState() => _State();
}

class _State extends State<SettingsProfilesRoute> with AutomaticKeepAliveClientMixin {
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

    Widget get _appBar => LSAppBar(title: 'Profiles');

    Widget get _body => LSListView(
        children: [
            SettingsProfileEnabledTile(),
            LSDivider(),
            SettingsProfileAddTile(),
            SettingsProfileRenameTile(),
            SettingsProfileDeleteTile(),
        ],
    );
}
