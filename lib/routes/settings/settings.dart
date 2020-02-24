import 'package:flutter/material.dart';
import 'package:lunasea/widgets/ui.dart';
//Pages
import './tabs/general.dart';
import './tabs/automation.dart';
import './tabs/clients.dart';
import './tabs/indexers.dart';


class Settings extends StatefulWidget {
    static const ROUTE_NAME = '/settings';

    @override
    State<Settings> createState() =>  _State();
}

class _State extends State<Settings> {
    int _currIndex = 0;

    final List<Widget> _navbarChildren = [
        SettingsGeneral(),
        SettingsAutomation(),
        SettingsClients(),
        SettingsIndexers(),
    ];

    final List<String> _navbarTitles = [
        'General',
        'Automation',
        'Clients',
        'Indexers',
    ];

    final List<Icon> _navbarIcons = [
        Icon(CustomIcons.user),
        Icon(CustomIcons.layers),
        Icon(CustomIcons.clients),
        Icon(CustomIcons.rss),
    ];

    @override
    Widget build(BuildContext context) => Scaffold(
        body: _navbarChildren[_currIndex],
        bottomNavigationBar: LSBottomNavigationBar(
            index: _currIndex,
            icons: _navbarIcons,
            titles: _navbarTitles,
            onTap: _navOnTap,
        ),
    );

    void _navOnTap(int index) => setState(() {
        _currIndex = index;
    });
}
