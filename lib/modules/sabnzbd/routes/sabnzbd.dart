import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../sabnzbd.dart';

class SABnzbd extends StatefulWidget {
    static const ROUTE_NAME = '/sabnzbd';

    @override
    State<SABnzbd> createState() => _State();
}

class _State extends State<SABnzbd> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final _pageController = PageController();
    String _profileState = Database.currentProfileObject.toString();
    SABnzbdAPI _api = SABnzbdAPI.from(Database.currentProfileObject);

    final List _refreshKeys = [
        GlobalKey<RefreshIndicatorState>(),
        GlobalKey<RefreshIndicatorState>(),
    ];

    @override
    void initState() {
        super.initState();
        Future.microtask(() => Provider.of<SABnzbdModel>(context, listen: false).navigationIndex = 0);
    }

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
            );
        },
    );

    Widget get _drawer => LSDrawer(page: 'sabnzbd');

    Widget get _bottomNavigationBar => SABnzbdNavigationBar(pageController: _pageController);

    List<Widget> get _tabs => [
        Text(''),
        SABnzbdHistory(refreshIndicatorKey: _refreshKeys[1]),
    ];

    Widget get _body => Stack(
        children: [
            PageView(
                controller: _pageController,
                children: _api.enabled ? _tabs : List.generate(_tabs.length, (_) => LSNotEnabled('SABnzbd')),
                onPageChanged: _onPageChanged,
            ),
            Column(
                children: <Widget>[_bottomNavigationBar],
                mainAxisAlignment: MainAxisAlignment.end,
            ),
        ],
    );

    Widget get _appBar => LSAppBar(
        title: 'SABnzbd',
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
        List<dynamic> values = await SABnzbdDialogs.showSettingsPrompt(context);
        /** TODO */
    }

    void _onPageChanged(int index) => Provider.of<SABnzbdModel>(context, listen: false).navigationIndex = index;

    void _refreshProfile() {
        _api = SABnzbdAPI.from(Database.currentProfileObject);
        _profileState = Database.currentProfileObject.toString();
        _refreshAllPages();
    }

    void _refreshAllPages() {
        for(var key in _refreshKeys) key?.currentState?.show();
    }
}