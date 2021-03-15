import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

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
            String type = params['type'] != null && params['type'].length > 0 ? params['type'][0] : '';
            return _SettingsSystemLogsDetailsRoute(type: LunaLogType.ERROR.fromKey(type));
        }),
        transitionType: LunaRouter.transitionType,
    );
}

class _SettingsSystemLogsDetailsRoute extends StatefulWidget {
    final LunaLogType type;

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
            title: '${widget.type?.name ?? 'All'} Logs',
            scrollControllers: [scrollController],
        );
    }

    Widget _body() {
        return ValueListenableBuilder(
            valueListenable: Database.logsBox.listenable(),
            builder: (context, box, _) {
                List<LunaLogHiveObject> logs = filter(box);
                if((logs?.length ?? 0) == 0) return LunaMessage.goBack(
                    context: context,
                    text: 'No Logs Found',
                );
                return LunaListViewBuilder(
                    controller: scrollController,
                    itemCount: logs.length,
                    itemBuilder: (context, index) => SettingsSystemLogTile(log: logs[index]),
                );
            }
        );
    }

    List<LunaLogHiveObject> filter(Box<LunaLogHiveObject> box) {
        List<LunaLogHiveObject> logs;
        switch(widget.type) {
            case LunaLogType.WARNING: logs = box.values.where((log) => log.type == LunaLogType.WARNING).toList(); break;
            case LunaLogType.ERROR: logs = box.values.where((log) => log.type == LunaLogType.ERROR).toList(); break;
            case LunaLogType.CRITICAL: logs = box.values.where((log) => log.type == LunaLogType.CRITICAL).toList(); break;
            case LunaLogType.DEBUG: logs = box.values.where((log) => log.type == LunaLogType.DEBUG).toList(); break;
            default: logs = box.values.where((log) => log.type.enabled).toList(); break;
        }
        logs.sort((a,b) => (b?.timestamp?.toDouble() ?? double.maxFinite).compareTo(a?.timestamp?.toDouble() ?? double.maxFinite));
        return logs;
    }
}
