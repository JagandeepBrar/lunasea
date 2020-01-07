import 'package:flutter/material.dart';
import 'package:lunasea/pages/nzbget/subpages.dart';
import 'package:lunasea/system/constants.dart';
import 'package:lunasea/system/ui.dart';

class NZBGet extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return _NZBGetWidget();
    }
}

class _NZBGetWidget extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _NZBGetState();
    }
}

class _NZBGetState extends State<StatefulWidget> {
    static final List _refreshKeys = [
        GlobalKey<RefreshIndicatorState>(),
        GlobalKey<RefreshIndicatorState>(),
    ];
    static final List _scaffoldKeys = [
        GlobalKey<ScaffoldState>(),
        GlobalKey<ScaffoldState>(),
    ];
    final List<String> _titles = [
        'Queue',
        'History',
    ];
    int _currIndex = 0;

    final List<Icon> _icons = [
        Icon(Icons.queue),
        Icon(Icons.history),
    ];

    void _navOnTap(int index) {
        if(mounted) {
            setState(() {
                _currIndex = index;
            });
        }
    }

    @override
    void initState() {
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Stack(
                children: <Widget>[
                    Offstage(
                        offstage: _currIndex != 0,
                        child: TickerMode(
                            enabled: _currIndex == 0,
                            child: NZBGetQueue(
                                scaffoldKey: _scaffoldKeys[0],
                                refreshIndicatorKey: _refreshKeys[0],
                            ),
                        ),
                    ),
                    Offstage(
                        offstage: _currIndex != 1,
                        child: TickerMode(
                            enabled: _currIndex == 1,
                            child: NZBGetHistory(
                                scaffoldKey: _scaffoldKeys[1],
                                refreshIndicatorKey: _refreshKeys[1],
                            ),
                        ),
                    )
                ],
            ),
            appBar: _buildAppBar(),
            drawer: Navigation.getDrawer('nzbget', context),
            bottomNavigationBar: _buildBottomNavigationBar(),
        );
    }

    AppBar _buildAppBar() {
        return AppBar(
            title: Text(
                'NZBGet',
                style: TextStyle(
                    letterSpacing: Constants.LETTER_SPACING,
                ),
            ),
            centerTitle: false,
            elevation: 0,
            backgroundColor: Color(Constants.SECONDARY_COLOR),
            actions: <Widget>[
                GestureDetector(
                    child: Center(
                        child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: Colors.white54,
                                    letterSpacing: Constants.LETTER_SPACING,
                                ),
                                children: <TextSpan>[
                                    TextSpan(
                                        text: 'Idle',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                            color: Color(Constants.ACCENT_COLOR),
                                        ),
                                    ),
                                    TextSpan(
                                        text: '\n―\t\t•\t\t―',
                                    ),
                                ],
                            ),
                            overflow: TextOverflow.fade,
                            maxLines: 2,
                            softWrap: false,
                            textAlign: TextAlign.right,
                        ),
                    ),
                    onTap: () async {
                    },
                ),
                IconButton(
                    icon: Elements.getIcon(Icons.more_vert),
                    tooltip: 'More Settings',
                    onPressed: () async {},
                ),
            ],
        );
    }

    BottomNavigationBar _buildBottomNavigationBar() {
        return BottomNavigationBar(
            currentIndex: _currIndex,
            type: BottomNavigationBarType.fixed,
            fixedColor: Color(Constants.ACCENT_COLOR),
            elevation: 0.0,
            onTap: _navOnTap,
            items: [
                for(int i =0; i<_icons.length; i++)
                    BottomNavigationBarItem(
                        icon: _icons[i],
                        title: Text(_titles[i]),
                    )
            ],
        );
    }
}
