import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/database/tables/bios.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/router/routes/settings.dart';
import 'package:lunasea/system/filesystem/filesystem.dart';
import 'package:lunasea/types/log_type.dart';

class SystemLogsRoute extends StatefulWidget {
  const SystemLogsRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<SystemLogsRoute> createState() => _State();
}

class _State extends State<SystemLogsRoute> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
      bottomNavigationBar: _bottomActionBar(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'Logs',
      scrollControllers: [scrollController],
    );
  }

  Widget _bottomActionBar() {
    return LunaBottomActionBar(
      actions: [
        _exportLogs(),
        _clearLogs(),
      ],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        LunaBlock(
          title: 'All Logs',
          body: const [TextSpan(text: 'View Logs of All Types')],
          trailing: const LunaIconButton(icon: Icons.developer_mode_rounded),
          onTap: () async => _viewLogs(null),
        ),
        ...List.generate(
          LunaLogType.values.length,
          (index) {
            if (LunaLogType.values[index].enabled)
              return LunaBlock(
                title: LunaLogType.values[index].title,
                body: [TextSpan(text: LunaLogType.values[index].description)],
                trailing: LunaIconButton(icon: LunaLogType.values[index].icon),
                onTap: () async => _viewLogs(LunaLogType.values[index]),
              );
            return Container(height: 0.0);
          },
        ),
        LunaDivider(),
        _sentryLogging(),
      ],
    );
  }

  Future<void> _viewLogs(LunaLogType? type) async {
    SettingsRoutes.SYSTEM_LOGS_DETAILS.go(params: {
      'type': type?.key ?? 'all',
    });
  }

  Widget _sentryLogging() {
    const db = BIOSDatabase.SENTRY_LOGGING;
    return db.listenableBuilder(
      builder: (context, _) => LunaBlock(
        title: 'settings.SentryLogging'.tr(),
        body: [TextSpan(text: 'settings.SentryLoggingDescription'.tr())],
        trailing: LunaSwitch(
          value: db.read(),
          onChanged: db.update,
        ),
      ),
    );
  }

  Widget _clearLogs() {
    return LunaButton.text(
      text: 'Clear',
      icon: LunaIcons.DELETE,
      color: LunaColours.red,
      onTap: () async {
        bool result = await SettingsDialogs().clearLogs(context);
        if (result) {
          LunaLogger().clear();
          showLunaSuccessSnackBar(
            title: 'Logs Cleared',
            message: 'All recorded logs have been cleared',
          );
        }
      },
    );
  }

  Widget _exportLogs() {
    return Builder(
      builder: (context) => LunaButton.text(
        text: 'Export',
        icon: LunaIcons.DOWNLOAD,
        onTap: () async {
          showLunaInfoSnackBar(
            title: 'Exporting Logs',
            message: 'Please wait...',
          );
          String data = await LunaLogger().export();
          bool result = await LunaFileSystem()
              .save(context, 'logs.json', utf8.encode(data));
          if (result)
            showLunaSuccessSnackBar(
                title: 'Saved Logs',
                message: 'Logs have been successfully saved');
        },
      ),
    );
  }
}
