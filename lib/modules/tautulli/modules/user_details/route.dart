import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliUserDetailsRoute extends StatefulWidget {
    final TautulliTableUser user;

    TautulliUserDetailsRoute({
        Key key,
        @required this.user,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<TautulliUserDetailsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    PageController _pageController;

    @override
    void initState() {
        super.initState();
        _pageController = PageController(initialPage: Provider.of<TautulliState>(context, listen: false).userDetailsNavigationIndex);
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        bottomNavigationBar: _bottomNavigationBar,
        body: _body,
    );
    
    Widget get _appBar => LSAppBar(title: widget.user.friendlyName);

    Widget get _bottomNavigationBar => TautulliUserDetailsNavigationBar(pageController: _pageController);

    List<Widget> get _tabs => [
        TautulliUserDetailsProfile(user: widget.user),
        TautulliUserDetailsHistory(user: widget.user),
        TautulliUserDetailsSyncedItems(user: widget.user),
        TautulliUserDetailsIPAddresses(user: widget.user),
    ];

    Widget get _body => PageView(
        controller: _pageController,
        children: _tabs,
        onPageChanged: _onPageChanged,
    );

    void _onPageChanged(int index) => Provider.of<TautulliState>(context, listen: false).userDetailsNavigationIndex = index;
}
