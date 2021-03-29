import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/dashboard.dart';
import 'package:tuple/tuple.dart';

class Dashboard extends StatefulWidget {
    static const ROUTE_NAME = '/';
    
    @override
    State<Dashboard> createState() => _State();
}

class _State extends State<Dashboard> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final _pageController = PageController(initialPage: DashboardDatabaseValue.NAVIGATION_INDEX.data);
    final List _refreshKeys = [GlobalKey<RefreshIndicatorState>()];
    String _profileState = Database.currentProfileObject.toString();

    @override
    Widget build(BuildContext context) => LunaWillPopScope(
        scaffoldKey: _scaffoldKey,
        child: ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [LunaDatabaseValue.ENABLED_PROFILE.key]),
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

    Widget get _drawer => LunaDrawer(page: LunaModule.DASHBOARD.key);

    Widget get _appBar => LunaAppBar(
        title: 'LunaSea',
        useDrawer: true,
        actions: Database.currentProfileObject.anyAutomationEnabled
            ? <Widget>[
                Selector<DashboardState, Tuple2<int, CalendarStartingType>>(
                    selector: (_, state) => Tuple2(state.navigationIndex, state.calendarStartingType),
                    builder: (context, state, _) => Visibility(
                        visible: state.item1 == 1,
                        child: LSIconButton(
                            icon: state.item2 == CalendarStartingType.CALENDAR
                                ? CalendarStartingType.SCHEDULE.icon
                                : CalendarStartingType.CALENDAR.icon,
                            onPressed: () async {
                                Provider.of<DashboardState>(context, listen: false).calendarStartingType = state.item2 == CalendarStartingType.CALENDAR
                                    ? CalendarStartingType.SCHEDULE
                                    : CalendarStartingType.CALENDAR;
                            },
                        ),
                    ),
                ),
            ]
            : null,
    );

    Widget get _bottomNavigationBar => DashboardNavigationBar(pageController: _pageController);

    Widget get _body => PageView(
        controller: _pageController,
        children: _tabs,
        onPageChanged: _onPageChanged,
    );

    List<Widget> get _tabs => [
        DashboardQuickAccess(),
        Database.currentProfileObject.anyAutomationEnabled
            ? DashboardCalendar(refreshIndicatorKey: _refreshKeys[0])
            : LSNotEnabled(Constants.NO_SERVICES_ENABLED, showButton: false),
    ];

    void _onPageChanged(int index) => Provider.of<DashboardState>(context, listen: false).navigationIndex = index;

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
