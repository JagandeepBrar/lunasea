import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/database/models/log.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/types/log_type.dart';

class SettingsSystemLogsDetailsRouter extends SettingsPageRouter {
  SettingsSystemLogsDetailsRouter() : super('/settings/logs/details/:type');

  @override
  Widget widget([LunaLogType? type]) => _Widget(type: type);

  @override
  Future<void> navigateTo(
    BuildContext context, [
    LunaLogType? type,
  ]) async {
    LunaRouter.router.navigateTo(context, route(type));
  }

  @override
  String route([LunaLogType? type]) {
    return fullRoute.replaceFirst(':type', type?.key ?? 'all');
  }

  @override
  void defineRoute(FluroRouter router) {
    super.withParameterRouteDefinition(
      router,
      (context, params) {
        String type =
            (params['type']?.isNotEmpty ?? false) ? params['type']![0] : '';
        return _Widget(type: LunaLogType.fromKey(type));
      },
    );
  }
}

class _Widget extends StatefulWidget {
  final LunaLogType? type;

  const _Widget({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  State<_Widget> createState() => _State();
}

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: '${widget.type?.title ?? 'All'} Logs',
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaBox.logs.watch(builder: (context, _) {
      List<LunaLogHiveObject> logs = filter();
      if (logs.isEmpty) {
        return LunaMessage.goBack(
          context: context,
          text: 'No Logs Found',
        );
      }
      return LunaListViewBuilder(
        controller: scrollController,
        itemCount: logs.length,
        itemBuilder: (context, index) => SettingsSystemLogTile(
          log: logs[index],
        ),
      );
    });
  }

  List<LunaLogHiveObject> filter() {
    List<LunaLogHiveObject> logs;
    const box = LunaBox.logs;

    switch (widget.type) {
      case LunaLogType.WARNING:
        logs =
            box.data.where((log) => log.type == LunaLogType.WARNING).toList();
        break;
      case LunaLogType.ERROR:
        logs = box.data.where((log) => log.type == LunaLogType.ERROR).toList();
        break;
      case LunaLogType.CRITICAL:
        logs =
            box.data.where((log) => log.type == LunaLogType.CRITICAL).toList();
        break;
      case LunaLogType.DEBUG:
        logs = box.data.where((log) => log.type == LunaLogType.DEBUG).toList();
        break;
      default:
        logs = box.data.where((log) => log.type.enabled).toList();
        break;
    }
    logs.sort((a, b) => (b.timestamp).compareTo(a.timestamp));
    return logs;
  }
}
