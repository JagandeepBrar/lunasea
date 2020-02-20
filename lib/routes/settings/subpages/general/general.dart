import 'package:flutter/material.dart';
import 'package:lunasea/widgets/ui.dart';
import 'package:lunasea/routes/settings/subpages/general/tabs/tabs.dart';

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
                appBar: LSAppBarTabs(
                    title: 'Settings',
                    tabTitles: _titles
                ),
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
