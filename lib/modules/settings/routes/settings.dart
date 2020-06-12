import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';


class Settings extends StatefulWidget {
    static const ROUTE_NAME = '/settings';

    @override
    State<Settings> createState() =>  _State();
}

class _State extends State<Settings> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final _pageController = PageController();

    @override
    void initState() {
        super.initState();
        Future.microtask(() => Provider.of<SettingsModel>(context, listen: false).navigationIndex = 0);
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        body: _body,
        appBar: _appBar,
        bottomNavigationBar: _bottomNavigationBar,
    );

    Widget get _appBar => LSAppBar(title: 'Settings');

    Widget get _body => PageView(
        controller: _pageController,
        children: _tabs,
        onPageChanged: _onPageChanged,
        physics: AlwaysScrollableScrollPhysics(),
    );

    Widget get _bottomNavigationBar => SettingsNavigationBar(pageController: _pageController);

    List<Widget> get _tabs => [
        SettingsGeneral(),
        SettingsModules(),
        SettingsSystem(),
    ];

    void _onPageChanged(int index) => Provider.of<SettingsModel>(context, listen: false).navigationIndex = index;
}
