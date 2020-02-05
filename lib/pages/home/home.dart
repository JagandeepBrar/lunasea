import 'package:flutter/material.dart';
import 'package:lunasea/system/ui.dart';
import 'package:lunasea/pages/home/subpages.dart';

class Home extends StatefulWidget {
    @override
    State<Home> createState() {
        return _State();
    }
}

class _State extends State<Home> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    int _currIndex = 1;

    final List<Widget> _children = [
        Statistics(),
        Summary(),
        Calendar(),
    ];

    final List<String> _titles = [
        'Statistics',
        'Summary',
        'Calendar',
    ];

    final List<Icon> _icons = [
        Icon(Icons.multiline_chart),
        Icon(Icons.home),
        Icon(Icons.calendar_today)
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
            key: _scaffoldKey,
            body: Stack(
                children: <Widget>[
                    for(int i=0; i < _children.length; i++)
                        Offstage(
                            offstage: _currIndex != i,
                            child: TickerMode(
                                enabled: _currIndex == i,
                                child: _children[i],
                            ),
                        )
                ],
            ),
            appBar: Navigation.getAppBar('LunaSea', context),
            drawer: Navigation.getDrawer('home', context),
            bottomNavigationBar: Navigation.getBottomNavigationBar(_currIndex, _icons, _titles, _navOnTap),
        );
    }
}
