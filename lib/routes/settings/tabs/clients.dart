import 'package:flutter/material.dart';
import 'package:lunasea/widgets/ui.dart';
//Tabs
import './clients/nzbget.dart';
import './clients/sabnzbd.dart';

class SettingsClients extends StatefulWidget {
    static const ROUTE_NAME = '/settings/clients';

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
