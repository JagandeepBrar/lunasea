import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliHistoryDetailsRouteArguments {
    final TautulliHistoryRecord history;

    TautulliHistoryDetailsRouteArguments({
        @required this.history,
    });
}

class TautulliHistoryDetailsRoute extends StatefulWidget {
    static const ROUTE_NAME = '/tautulli/history/details';

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<TautulliHistoryDetailsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    TautulliHistoryDetailsRouteArguments _arguments;

    @override
    void initState() {
        super.initState();
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
            body: _body,
        );

    Widget get _appBar => LSAppBar(
        title: _arguments.history.header,
        actions: [],
    );

    Widget get _body => Container();
}