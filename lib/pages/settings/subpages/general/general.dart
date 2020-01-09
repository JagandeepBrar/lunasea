import 'package:flutter/material.dart';
import 'package:lunasea/system/ui.dart';
import 'package:lunasea/pages/settings/subpages/general/tabs/tabs.dart';

class General extends StatefulWidget {
    @override
    State<General> createState() {
        return _State();
    }
}

class _State extends State<General> {
    final List<String> _titles = [
        'Profile',
        'Configuration',
        'Logs',
        'LunaSea',
    ];

    @override
    Widget build(BuildContext context) {
        return DefaultTabController(
            length: _titles.length,
            child: Scaffold(
                appBar: Navigation.getAppBarTabs('Settings', _titles, context),
                body: TabBarView(
                    children: <Widget>[
                        Profile(),
                        BackupRestore(),
                        Logs(),
                        LunaSea(),
                    ],
                ),
            ),
        );
    }
}
