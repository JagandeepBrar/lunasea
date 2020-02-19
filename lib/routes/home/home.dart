import 'package:flutter/material.dart';
import 'package:lunasea/widgets/ui.dart';
import 'package:lunasea/routes/home/subpages.dart';

class Home extends StatefulWidget {
    @override
    State<Home> createState() {
        return _State();
    }
}

class _State extends State<Home> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    int _currIndex = 0;

    final List<Widget> _children = [
        Summary(),
        Calendar(),
    ];

    final List<String> _titles = [
        'Summary',
        'Calendar',
    ];

    final List<Icon> _icons = [
        Icon(CustomIcons.home),
        Icon(CustomIcons.calendar)
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
            appBar: LSAppBar('LunaSea'),
            drawer: LSDrawer(page: 'home'),
            bottomNavigationBar: LSBottomNavigationBar(
                index: _currIndex,
                icons: _icons,
                titles: _titles,
                onTap: _navOnTap,
            ),
        );
    }
}
