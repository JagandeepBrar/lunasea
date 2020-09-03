import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliRoute extends StatefulWidget {

    static const String ROUTE = '/:profile/tautulli';
    static String enterRoute({
        String profile,
    }) => profile == null
        ? '/${LunaSeaDatabaseValue.ENABLED_PROFILE.data}/tautulli'
        : '/$profile/tautulli';


    @override
    State<TautulliRoute> createState() => _State();
}

class _State extends State<TautulliRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    PageController _pageController;

    @override
    void initState() {
        super.initState();
        _pageController = PageController(initialPage: Provider.of<TautulliState>(context, listen: false).navigationIndex);
    }

    @override
    Widget build(BuildContext context) => WillPopScope(
        onWillPop: _willPopScope,
        child: ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [ LunaSeaDatabaseValue.ENABLED_PROFILE.key ]),
            builder: (context, box, _) => ChangeNotifierProvider(
                create: (context) => TautulliLocalState(),
                child: Scaffold(
                    key: _scaffoldKey,
                    drawer: _drawer,
                    appBar: _appBar,
                    bottomNavigationBar: _bottomNavigationBar,
                    body: _body,
                ),
            ),
        ),
    );

    Future<bool> _willPopScope() async {
        if(_scaffoldKey.currentState.isDrawerOpen) return true;
        _scaffoldKey.currentState.openDrawer();
        return false;
    }

    Widget get _drawer => LSDrawer(page: 'tautulli');

    Widget get _bottomNavigationBar => TautulliNavigationBar(pageController: _pageController);

    List<Widget> get _tabs => [
        TautulliActivityRoute(),
        TautulliUsersRoute(),
        TautulliHistoryRoute(),
        TautulliMoreRoute(),
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
            if((Database.profilesBox.get(element) as ProfileHiveObject)?.tautulliEnabled ?? false) value.add(element);
            return value;
        }),
        actions: Provider.of<TautulliState>(context).enabled ? [TautulliGlobalSettings()] : null,
    );

    void _onPageChanged(int index) => Provider.of<TautulliState>(context, listen: false).navigationIndex = index;
}
