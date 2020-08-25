import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliUserDetailsRouteArguments {
    final TautulliTableUser user;

    TautulliUserDetailsRouteArguments({
        @required this.user,
    });
}

class TautulliUserDetailsRoute extends StatefulWidget {
    static const ROUTE_NAME = '/tautulli/user/details';

    TautulliUserDetailsRoute({
        Key key,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<TautulliUserDetailsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    TautulliUserDetailsRouteArguments _arguments;
    PageController _pageController;

    @override
    void initState() {
        super.initState();
        _pageController = PageController(initialPage: Provider.of<TautulliState>(context, listen: false).userDetailsNavigationIndex);
        SchedulerBinding.instance.scheduleFrameCallback((_) {
            setState(() => _arguments = ModalRoute.of(context).settings.arguments);
        });
    }

    @override
    Widget build(BuildContext context) => _arguments == null
        ? Scaffold()
        : Scaffold(
            key: _scaffoldKey,
            appBar: _appBar,
            bottomNavigationBar: _bottomNavigationBar,
            body: _body,
        );
    
    Widget get _appBar => LSAppBar(
        title: _arguments.user.friendlyName,
    );

    Widget get _bottomNavigationBar => TautulliUserDetailsNavigationBar(pageController: _pageController);

    List<Widget> get _tabs => [
        TautulliUserDetailsProfile(user: _arguments.user),
        TautulliUserDetailsHistory(user: _arguments.user),
        TautulliUserDetailsSyncedItems(user: _arguments.user),
        TautulliUserDetailsIPAddresses(user: _arguments.user),
    ];

    Widget get _body => PageView(
        controller: _pageController,
        children: _tabs,
        onPageChanged: _onPageChanged,
    );

    void _onPageChanged(int index) => Provider.of<TautulliState>(context, listen: false).userDetailsNavigationIndex = index;
}
