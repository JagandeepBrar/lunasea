import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class Tautulli extends StatefulWidget {
    static const ROUTE_NAME = '/tautulli';

    @override
    State<Tautulli> createState() => _State();
}

class _State extends State<Tautulli> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    PageController _pageController;

    @override
    void initState() {
        super.initState();
        _pageController = PageController(initialPage: Provider.of<TautulliState>(context, listen: false).navigationIndex);
    }

    @override
    Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
            if(_scaffoldKey.currentState.isDrawerOpen) {
                return true;
            } else {
                _scaffoldKey.currentState.openDrawer();
                return false;
            }
        },
        child: Scaffold(
            key: _scaffoldKey,
            drawer: _drawer,
            appBar: _appBar,
            bottomNavigationBar: _bottomNavigationBar,
            body: _body,
        ),
    );

    Widget get _drawer => LSDrawer(page: 'tautulli');

    Widget get _bottomNavigationBar => TautulliNavigationBar(pageController: _pageController);

    List<Widget> get _tabs => [
        Container(child: Text('1')),
        Container(child: Text('2')),
        Container(child: Text('3')),
        Container(child: Text('4')),
    ];

    Widget get _body => Selector<TautulliState, bool>(
        selector: (_, state) => state.enabled,
        builder: (context, enabled, _) => PageView(
            controller: _pageController,
            children: enabled ? _tabs : List.generate(_tabs.length, (_) => LSNotEnabled('Tautulli')),
            onPageChanged: _onPageChanged,
        ),
    );

    Widget get _appBar => LSAppBarDropdown(
        context: context,
        title: 'Tautulli',
        profiles: Database.profilesBox.keys.fold([], (value, element) {
            if((Database.profilesBox.get(element) as ProfileHiveObject).tautulliEnabled)
                value.add(element);
            return value;
        }),
        actions: Provider.of<TautulliState>(context).enabled
            ? [
                LSIconButton(
                    icon: Icons.more_vert,
                    onPressed: () async => _globalSettings(),
                )
            ]
            : null,
    );

    void _onPageChanged(int index) => Provider.of<TautulliState>(context, listen: false).navigationIndex = index;

    Future<void> _globalSettings() async {
        List values = await TautulliDialogs.globalSettings(context);
        if(values[0]) switch(values[1]) {
            case 'web_gui': Provider.of<TautulliState>(context, listen: false).host.lsLinks_OpenLink(); break;
        }
    }
}
