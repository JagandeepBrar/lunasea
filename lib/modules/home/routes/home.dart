import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/home.dart';

class Home extends StatefulWidget {
    static const ROUTE_NAME = '/';
    
    @override
    State<Home> createState() => _State();
}

class _State extends State<Home> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final _pageController = PageController(initialPage: HomeDatabaseValue.NAVIGATION_INDEX.data);
    final List _refreshKeys = [GlobalKey<RefreshIndicatorState>()];
    String _profileState = Database.currentProfileObject.toString();

    @override
    Widget build(BuildContext context) => WillPopScope(
        onWillPop: _willPopScope,
        child: ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [LunaSeaDatabaseValue.ENABLED_PROFILE.key]),
            builder: (context, lunaBox, widget) {
                return ValueListenableBuilder(
                    valueListenable: Database.profilesBox.listenable(keys: [Database.currentProfile]),
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
        ),
    );

    Future<bool> _willPopScope() async {
        if(_scaffoldKey.currentState.isDrawerOpen) {
            return true;
        } else {
            _scaffoldKey.currentState.openDrawer();
            return false;
        }
    }

    Widget get _drawer => LSDrawer(page: 'home');

    Widget get _appBar => LSAppBar(
        title: Constants.APPLICATION_NAME,
        actions: <Widget>[
            Visibility(
                visible: Provider.of<HomeState>(context).navigationIndex == 1,
                child: LSIconButton(
                    icon: Provider.of<HomeState>(context).calendarStartingType == CalendarStartingType.CALENDAR
                        ? CalendarStartingType.SCHEDULE.icon
                        : CalendarStartingType.CALENDAR.icon,
                    onPressed: () async {
                        HomeState _state = Provider.of<HomeState>(context, listen: false);
                        _state.calendarStartingType = _state.calendarStartingType == CalendarStartingType.CALENDAR
                            ? CalendarStartingType.SCHEDULE
                            : CalendarStartingType.CALENDAR;
                    },
                ),
            ),
        ],
    );

    Widget get _bottomNavigationBar => HomeNavigationBar(pageController: _pageController);

    Widget get _body => PageView(
        controller: _pageController,
        children: _tabs,
        onPageChanged: _onPageChanged,
    );

    List<Widget> get _tabs => [
        HomeQuickAccess(),
        Database.currentProfileObject.anythingEnabled
            ? HomeCalendar(refreshIndicatorKey: _refreshKeys[0])
            : LSNotEnabled(Constants.NO_SERVICES_ENABLED, showButton: false),
    ];

    void _onPageChanged(int index) => Provider.of<HomeState>(context, listen: false).navigationIndex = index;

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
