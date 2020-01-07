import 'package:flutter/material.dart';
import 'package:lunasea/system/ui.dart';
import 'package:lunasea/pages/settings/subpages/clients/tabs/tabs.dart';

class Clients extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return _ClientsWidget();
    }
}

class _ClientsWidget extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _ClientsState();
    }
}

class _ClientsState extends State<StatefulWidget> {
    final List<String> _titles = [
        'NZBGet',
        'SABnzbd',
    ];

    @override
    Widget build(BuildContext context) {
        return DefaultTabController(
            length: _titles.length,
            child: Scaffold(
                appBar: Navigation.getAppBarTabs('Settings', _titles, context),
                body: TabBarView(
                    children: <Widget>[
                        NZBGet(),
                        SABnzbd(),
                    ],
                ),
            ),
        );
    }
}
