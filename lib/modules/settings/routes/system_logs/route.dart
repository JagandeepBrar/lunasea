import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsSystemLogsRouter extends SettingsPageRouter {
  SettingsSystemLogsRouter() : super('/settings/logs');

  @override
  _Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) {
    super.noParameterRouteDefinition(router);
  }
}

class _Widget extends StatefulWidget {
  @override
  State<_Widget> createState() => _State();
}

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
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
    return LunaListView(controller: scrollController, children: [
      LunaListTile(
        context: context,
        title: LunaText.title(text: 'All Logs'),
        subtitle: LunaText.subtitle(text: 'View Logs of All Types'),
        trailing: LunaIconButton(icon: Icons.developer_mode),
        onTap: () async => _viewLogs('all'),
      ),
      ...List.generate(
        LunaLogType.values.length,
        (index) {
          if (LunaLogType.values[index].enabled)
            return LunaListTile(
              context: context,
              title: LunaText.title(text: LunaLogType.values[index].name),
              subtitle: LunaText.subtitle(
                  text: LunaLogType.values[index].description),
              trailing: LunaIconButton(icon: LunaLogType.values[index].icon),
              onTap: () async => _viewLogs(LunaLogType.values[index].key),
            );
          return Container(height: 0.0);
        },
      ),
    ]);
  }

  Future<void> _viewLogs(String type) async =>
      SettingsSystemLogsDetailsRouter().navigateTo(context, type: type);

  Widget _clearLogs() {
    return LunaButton.text(
      text: 'Clear',
      icon: Icons.delete,
      color: LunaColours.red,
      onTap: () async {
        bool result = await SettingsDialogs().clearLogs(context);
        if (result) {
          LunaLogger().clearLogs();
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
        icon: Icons.file_download,
        onTap: () async {
          showLunaInfoSnackBar(
            title: 'Exporting Logs',
            message: 'Please wait...',
          );
          String data = await LunaLogger().exportLogs();
          bool result = await LunaFileSystem()
              .export(context, 'logs.json', utf8.encode(data));
          if (result)
            showLunaSuccessSnackBar(
                title: 'Saved Logs',
                message: 'Logs have been successfully saved');
        },
      ),
    );
  }
}
