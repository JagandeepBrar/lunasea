import 'package:flutter/material.dart';
import 'package:lunasea/system/ui.dart';
import 'package:lunasea/pages/settings/subpages.dart';

class Settings extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return _SettingsWidget();
    }
}

class _SettingsWidget extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _SettingsState();
    }
}

class _SettingsState extends State<StatefulWidget> {
    int _currIndex = 0;

    final List<Widget> _children = [
        General(),
        Automation(),
        Clients(),
        Monitoring(),
    ];

    final List<String> _titles = [
        'General',
        'Automation',
        'Clients',
        'Monitoring',
    ];

    final List<Icon> _icons = [
        Icon(Icons.person),
        Icon(Icons.layers),
        Icon(Icons.file_download),
        Icon(Icons.multiline_chart),

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
