import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsSystemLogsDetailsRouter extends LunaPageRouter {
    SettingsSystemLogsDetailsRouter() : super('/settings/logs/details/:type');

    @override
    Future<void> navigateTo(BuildContext context, { @required String type }) async => LunaRouter.router.navigateTo(context, route(type: type));

    @override
    String route({ @required String type }) => fullRoute.replaceFirst(':type', type);

    @override
    void defineRoute(FluroRouter router) => router.define(
        fullRoute,
        handler: Handler(handlerFunc: (context, params) {
            String type = params['type'] != null && params['type'].length > 0 ? params['type'][0] : 'All';
            type ??= 'All';
            return _SettingsSystemLogsDetailsRoute(type: type);
        }),
        transitionType: LunaRouter.transitionType,
    );
}

class _SettingsSystemLogsDetailsRoute extends StatefulWidget {
    final String type;

    _SettingsSystemLogsDetailsRoute({
        Key key,
        @required this.type,
    }) : super(key: key);

    @override
    State<_SettingsSystemLogsDetailsRoute> createState() => _State();
}

class _State extends State<_SettingsSystemLogsDetailsRoute> with LunaScrollControllerMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar(),
        body: _body(),
    );

    Widget _appBar() {
        return LunaAppBar(
            title: '${widget.type ?? 'Unknown'} Logs',
            scrollControllers: [scrollController],
        );
    }

    Widget _body() {
        return null;
    }
}
