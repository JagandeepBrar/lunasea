import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../nzbget.dart';

class NZBGet extends StatefulWidget {
    static const ROUTE_NAME = '/nzbget';

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<NZBGet> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    int _currIndex = 0;
    String _profileState = Database.currentProfileObject.toString();
    NZBGetAPI _api = NZBGetAPI.from(Database.currentProfileObject);

    final List _refreshKeys = [
        GlobalKey<RefreshIndicatorState>(),
        GlobalKey<RefreshIndicatorState>(),
    ];

    final List<Icon> _navbarIcons = [
        Icon(CustomIcons.queue),
        Icon(CustomIcons.history)
    ];

    final List<String> _navbarTitles = [
        'Queue',
        'History',
    ];

    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: ['profile']),
        builder: (context, box, widget) {
            if(_profileState != Database.currentProfileObject.toString()) _refreshProfile();
            return Scaffold(
                key: _scaffoldKey,
                body: _body,
                drawer: _drawer,
                appBar: _appBar,
                bottomNavigationBar: _bottomNavigationBar,
            );
        },
    );

    Widget get _drawer => LSDrawer(page: 'nzbget');

    Widget get _bottomNavigationBar => LSBottomNavigationBar(
        index: _currIndex,
        icons: _navbarIcons,
        titles: _navbarTitles,
        onTap: _navOnTap,
    );

    List<Widget> get _tabs => [
        Text('Queue'),
        Text('History'),
        // NZBGetQueue(
        //     refreshIndicatorKey: _refreshKeys[0],
        // ),
        // NZBGetHistory(
        //     refreshIndicatorKey: _refreshKeys[1],
        // ),
    ];

    Widget get _body => Stack(
        children: List.generate(_tabs.length, (index) => Offstage(
            offstage: _currIndex != index,
            child: TickerMode(
                enabled: _currIndex == index,
                child: _api.enabled
                    ? _tabs[index]
                    : LSNotEnabled('NZBGet'),
            ),
        )),
    );

    Widget get _appBar => LSAppBar(
        title: 'NZBGet',
        actions: _api.enabled
            ? <Widget>[
                LSIconButton(
                    icon: Icons.more_vert,
                    onPressed: () async => _handlePopup(),
                )
            ]
            : null,
    );

    Future<void> _handlePopup() async {
        List<dynamic> values = await NZBGetDialogs.showSettingsPrompt(context);
        if(values[0]) switch(values[1]) {
            /** TODO */
        }
    }

    void _navOnTap(int index) => setState(() => _currIndex = index);

    void _refreshProfile() {
        _api = NZBGetAPI.from(Database.currentProfileObject);
        _profileState = Database.currentProfileObject.toString();
        _refreshAllPages();
    }

    void _refreshAllPages() {
        for(var key in _refreshKeys) key?.currentState?.show();
    }
}