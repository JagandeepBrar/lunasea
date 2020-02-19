import 'package:flutter/material.dart';
import 'package:lunasea/widgets/ui.dart';
import 'package:lunasea/routes/settings/subpages/automation/tabs/tabs.dart';

class Automation extends StatefulWidget {
    @override
    State<Automation> createState() {
        return _State();
    }
}

class _State extends State<Automation> {
    final List<String> _titles = [
        'Lidarr',
        'Radarr',
        'Sonarr',
    ];

    @override
    Widget build(BuildContext context) {
        return DefaultTabController(
            length: _titles.length,
            child: Scaffold(
                appBar: LSAppBarTabs(
                    title: 'Settings',
                    tabTitles: _titles,
                ),
                body: TabBarView(
                    children: <Widget>[
                        Lidarr(),
                        Radarr(),
                        Sonarr(),
                    ],
                ),
            ),
        );
    }
}
