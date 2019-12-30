import 'package:flutter/material.dart';
import 'package:lunasea/system/ui.dart';
import 'package:lunasea/pages/settings/subpages/automation/tabs/tabs.dart';

class Automation extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return _AutomationWidget();
    }
}

class _AutomationWidget extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _AutomationState();
    }
}

class _AutomationState extends State<StatefulWidget> {
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
                appBar: Navigation.getAppBarTabs('Settings', _titles, context),
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
