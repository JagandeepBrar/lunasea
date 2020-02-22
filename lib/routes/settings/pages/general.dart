import 'package:flutter/material.dart';
import 'package:lunasea/widgets/ui.dart';
//Tabs
import './general/profile.dart';
import './general/configuration.dart';
import './general/logs.dart';
import './general/lunasea.dart';


class SettingsGeneral extends StatefulWidget {
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
    Widget build(BuildContext context) {
        return DefaultTabController(
            length: _tabTitles.length,
            child: Scaffold(
                appBar: LSAppBarTabs(
                    title: 'Settings',
                    tabTitles: _tabTitles,
                ),
                body: TabBarView(children: _tabChildren),
            ),
        );
    }
}
