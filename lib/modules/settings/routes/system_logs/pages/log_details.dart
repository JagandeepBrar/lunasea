import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/database/models/log.dart';
import 'package:lunasea/modules/settings/routes/system_logs/widgets/log_tile.dart';
import 'package:lunasea/types/log_type.dart';

class SystemLogsDetailsRoute extends StatefulWidget {
  final LunaLogType? type;

  const SystemLogsDetailsRoute({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  State<SystemLogsDetailsRoute> createState() => _State();
}

class _State extends State<SystemLogsDetailsRoute>
    with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
    );
  }

  PreferredSizeWidget _appBar() {
    return LunaAppBar(
      title: 'settings.Logs'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaBox.logs.listenableBuilder(builder: (context, _) {
      List<LunaLog> logs = filter();
      if (logs.isEmpty) {
        return LunaMessage.goBack(
          context: context,
          text: 'settings.NoLogsFound'.tr(),
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

  List<LunaLog> filter() {
    List<LunaLog> logs;
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
