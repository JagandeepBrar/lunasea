import 'package:flutter/material.dart';
import 'package:lunasea/widgets/ui.dart';
//Tabs
import './general/profile.dart';
import './general/configuration.dart';
import './general/logs.dart';
import './general/lunasea.dart';


class SettingsGeneral extends StatefulWidget {
    static const ROUTE_NAME = '/settings/general';

    @override
    State<SettingsGeneral> createState() => _State();
}

class _State extends State<SettingsGeneral> {
    final List<String> _tabTitles = [
        'Profile',
        'Configuration',
        'Logs',
        'LunaSea',
    ];

    final List<Widget> _tabChildren = [
        SettingsGeneralProfile(),
        SettingsGeneralConfiguration(),
        SettingsGeneralLogs(),
        SettingsGeneralLunaSea(),
    ];

    @override
    Widget build(BuildContext context) => DefaultTabController(
        length: _tabTitles.length,
        child: Scaffold(
            appBar: _appBar,
            body: _body,
        ),
    );

    Widget get _appBar => LSAppBarTabs(
        title: 'Settings',
        tabTitles: _tabTitles,
    );

    Widget get _body => TabBarView(children: _tabChildren);
}
