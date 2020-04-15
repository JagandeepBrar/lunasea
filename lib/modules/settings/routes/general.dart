import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../settings.dart';

class SettingsGeneral extends StatefulWidget {
    static const ROUTE_NAME = '/settings/general';
    
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SettingsGeneral> with AutomaticKeepAliveClientMixin {
    @override
    bool get wantKeepAlive => true;

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            body: _body,
        );
    }

    Widget get _body => LSListView(
        children: <Widget>[
            ..._profile,
            ..._configuration,
            ..._logs,
        ],
    );

    List<Widget> get _profile => [
        LSHeader(text: 'Profile'),
        SettingsGeneralEnabledProfileTile(),
        LSDivider(),
        SettingsGeneralAddProfileTile(),
        SettingsGeneralRenameProfileTile(),
        SettingsGeneralDeleteProfileTile(),
    ];

    List<Widget> get _configuration => [
        LSHeader(text: 'Configuration'),
        SettingsGeneralConfigurationBackupTile(),
        SettingsGeneralConfigurationRestoreTile(),
    ];

    List<Widget> get _logs => [
        LSHeader(text: 'Logs'),
        SettingsGeneralViewLogsTile(),
        LSDivider(),
        SettingsGeneralExportLogsTile(),
        SettingsGeneralClearLogsTile(),
    ];
}
