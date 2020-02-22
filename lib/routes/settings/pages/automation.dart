import 'package:flutter/material.dart';
import 'package:lunasea/widgets/ui.dart';
//Tabs
import './automation/lidarr.dart';
import './automation/radarr.dart';
import './automation/sonarr.dart';

class SettingsAutomation extends StatefulWidget {
    @override
    State<SettingsAutomation> createState() => _State();
}

class _State extends State<SettingsAutomation> {
    final List<String> _tabTitles = [
        'Lidarr',
        'Radarr',
        'Sonarr',
    ];

    final List<Widget> _tabChildren = [
        SettingsAutomationLidarr(),
        SettingsAutomationRadarr(),
        SettingsAutomationSonarr(),
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
