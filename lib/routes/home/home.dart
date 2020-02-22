import 'package:flutter/material.dart';
import 'package:lunasea/core/constants.dart';
import 'package:lunasea/core/database.dart';
import 'package:lunasea/widgets/ui.dart';
import 'package:lunasea/routes/home/subpages.dart';

class Home extends StatefulWidget {
    static const ROUTE_NAME = '/';
    
    @override
    State<Home> createState() {
        return _State();
    }
}

class _State extends State<Home> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    int _currIndex = 0;
    String _profileState = Database.currentProfileObject.toString();

    final List _refreshKeys = [
        GlobalKey<RefreshIndicatorState>(),
        GlobalKey<RefreshIndicatorState>(),
    ];

    final List<String> _navbarTitles = [
        'Summary',
        'Calendar',
    ];

    final List<Icon> _navbarIcons = [
        Icon(CustomIcons.home),
        Icon(CustomIcons.calendar)
    ];

    @override
    Widget build(BuildContext context) {
        return ValueListenableBuilder(
            valueListenable: Database.getLunaSeaBox().listenable(keys: ['profile']),
            builder: (context, lunaBox, widget) {
                return ValueListenableBuilder(
                    valueListenable: Database.getProfilesBox().listenable(keys: [Database.currentProfile]),
                    builder: (context, profileBox, widget) {
                        if(_profileState != Database.currentProfileObject.toString()) _refreshProfile();
                        return Scaffold(
                            key: _scaffoldKey,
                            body: _body,
                            drawer: _drawer,
                            appBar: _appBar,
                            bottomNavigationBar: _bottomNavigationBar,
                        );
                    }
                );
            },
        );
    }

    Widget get _drawer => LSDrawer(page: 'home');

    Widget get _bottomNavigationBar => LSBottomNavigationBar(
        index: _currIndex,
        icons: _navbarIcons,
        titles: _navbarTitles,
        onTap: _navOnTap,
    );

    Widget get _body => Stack(
        children: List.generate(_tabs.length, (index) => Offstage(
            offstage: _currIndex != index,
            child: TickerMode(
                enabled: _currIndex == index,
                child: Database.currentProfileObject.anythingEnabled
                    ? _tabs[index]
                    : LSNotEnabled(Constants.NO_SERVICES_ENABLED, showButton: false),
            ),
        )),
    );

    Widget get _appBar => LSAppBar(
        title: 'LunaSea',
        actions: null,
    );

    List<Widget> get _tabs => [
        Summary(refreshIndicatorKey: _refreshKeys[0]),
        Calendar(refreshIndicatorKey: _refreshKeys[1]),
    ];

    void _navOnTap(int index) {
        if(mounted) setState(() {
            _currIndex = index;
        });
    }

    void _refreshProfile() {
        _profileState = Database.currentProfileObject.toString();
        _refreshAllPages();
    }

    void _refreshAllPages() {
        for(var key in _refreshKeys) {
            key?.currentState?.show();
        }
    }
}
