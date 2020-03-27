import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../settings.dart';


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
        bottomNavigationBar: _bottomNavigationBar,
    );

    Widget get _body => PageView(
        controller: _pageController,
        children: _tabs,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
    );

    Widget get _bottomNavigationBar => SettingsNavigationBar(pageController: _pageController);

    List<Widget> get _tabs => [
        SettingsGeneral(),
        SettingsAutomation(),
        SettingsClients(),
        SettingsIndexers(),
    ];

    void _onPageChanged(int index) => Provider.of<SettingsModel>(context, listen: false).navigationIndex = index;
}
