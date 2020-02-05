import 'package:flutter/material.dart';
import 'package:lunasea/system/ui.dart';
import 'package:lunasea/pages/settings/subpages.dart';

class Settings extends StatefulWidget {
    @override
    State<Settings> createState() {
        return _State();
    }
}

class _State extends State<Settings> {
    int _currIndex = 0;

    final List<Widget> _children = [
        General(),
        Automation(),
        Clients(),
        Indexers(),
    ];

    final List<String> _titles = [
        'General',
        'Automation',
        'Clients',
        'Indexers',
    ];

    final List<Icon> _icons = [
        Icon(CustomIcons.user),
        Icon(CustomIcons.layers),
        Icon(CustomIcons.clients),
        Icon(Icons.rss_feed),
    ];

    void _navOnTap(int index) {
        if(mounted) {
            setState(() {
                _currIndex = index;
            });
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: _children[_currIndex],
            bottomNavigationBar: Navigation.getBottomNavigationBar(_currIndex, _icons, _titles, _navOnTap),
        );
    }
}
