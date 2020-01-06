import 'package:flutter/material.dart';
import 'package:lunasea/system/ui.dart';
import 'package:lunasea/pages/settings/subpages/general/tabs/tabs.dart';

class General extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return _GeneralWidget();
    }
}

class _GeneralWidget extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _GeneralState();
    }
}

class _GeneralState extends State<StatefulWidget> {
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
