import 'package:flutter/material.dart';
import 'package:lunasea/widgets/ui.dart';
import 'package:lunasea/routes/settings/subpages/clients/tabs/tabs.dart';

class Clients extends StatefulWidget {
    @override
    State<Clients> createState() {
        return _State();
    }
}

class _State extends State<Clients> {
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
