import 'package:flutter/material.dart';
import 'package:lunasea/widgets/ui.dart';
//Tabs
import './clients/nzbget.dart';
import './clients/sabnzbd.dart';

class SettingsClients extends StatefulWidget {
    @override
    State<SettingsClients> createState() => _State();
}

class _State extends State<SettingsClients> {
    final List<String> _tabTitles = [
        'NZBGet',
        'SABnzbd',
    ];

    final List<Widget> _tabChildren = [
        SettingsClientsNZBGet(),
        SettingsClientsSABnzbd(),         
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
