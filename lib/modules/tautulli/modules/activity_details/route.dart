import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliActivityDetailsRouteArguments {
    final TautulliSession session;

    TautulliActivityDetailsRouteArguments({
        @required this.session,
    });
}

class TautulliActivityDetailsRoute extends StatefulWidget {
    static const ROUTE_NAME = '/tautulli/activity/details';

    TautulliActivityDetailsRoute({
        Key key,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<TautulliActivityDetailsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    TautulliActivityDetailsRouteArguments _arguments;

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
        );

    Widget get _appBar => LSAppBar(
        title: _arguments.session.title,
        actions: [
            TautulliActivityDetailsTerminateSession(session: _arguments.session),
        ],
    );
}