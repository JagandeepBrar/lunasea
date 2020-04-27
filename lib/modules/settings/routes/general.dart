import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

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
        LSHeader(
            text: 'Profile',
            subtitle: 'Profiles allow you to use multiple instances of modules within LunaSea',
        ),
        SettingsGeneralEnabledProfileTile(),
        LSDivider(),
        SettingsGeneralAddProfileTile(),
        SettingsGeneralRenameProfileTile(),
        SettingsGeneralDeleteProfileTile(),
    ];

    List<Widget> get _configuration => [
        LSHeader(
            text: 'Configuration',
            subtitle: 'Backup and restore your module configurations (Does not backup or restore customization options)',
        ),
        SettingsGeneralConfigurationBackupTile(),
        SettingsGeneralConfigurationRestoreTile(),
    ];

    List<Widget> get _logs => [
        LSHeader(
            text: 'Logs',
            subtitle: 'View, export, and clear your on-device logs (Logs are never sent off your device within LunaSea)',
        ),
        SettingsGeneralViewLogsTile(),
        LSDivider(),
        SettingsGeneralExportLogsTile(),
        SettingsGeneralClearLogsTile(),
    ];
}
