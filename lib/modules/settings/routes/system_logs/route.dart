import 'dart:io';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsSystemLogsRouter extends LunaPageRouter {
    SettingsSystemLogsRouter() : super('/settings/logs');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsSystemLogsRoute());
}

class _SettingsSystemLogsRoute extends StatefulWidget {
    @override
    State<_SettingsSystemLogsRoute> createState() => _State();
}

class _State extends State<_SettingsSystemLogsRoute> with LunaScrollControllerMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar(),
            body: _body(),
        );
    }

    Widget _appBar() {
        return LunaAppBar(
            title: 'Logs',
            scrollControllers: [scrollController],
        );
    }

    Widget _body() {
        return LunaListView(
            controller: scrollController,
            children: [
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'All Logs'),
                    subtitle: LunaText.subtitle(text: 'View Logs of All Types'),
                    trailing: LunaIconButton(icon: Icons.developer_mode),
                    onTap: () async => _viewLogs('All'),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Warning'),
                    subtitle: LunaText.subtitle(text: 'View Warning Logs'),
                    trailing: LunaIconButton(icon: Icons.warning),
                    onTap: () async => _viewLogs('Warning'),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Error'),
                    subtitle: LunaText.subtitle(text: 'View Error Logs'),
                    trailing: LunaIconButton(icon: Icons.report),
                    onTap: () async => _viewLogs('Error'),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Fatal'),
                    subtitle: LunaText.subtitle(text: 'View Fatal Logs'),
                    trailing: LunaIconButton(icon: Icons.new_releases),
                    onTap: () async => _viewLogs('Fatal'),
                ),
                LunaDivider(),
                _exportLogs(),
                _clearLogs(),
            ]
        );
    }

    Future<void> _viewLogs(String type) async => SettingsSystemLogsDetailsRouter().navigateTo(context, type: type);

    Widget _clearLogs() {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Clear'),
            subtitle: LunaText.subtitle(text: 'Clear All Recorded Logs'),
            trailing: LunaIconButton(icon: Icons.delete),
            onTap: () async {
                bool result = await SettingsDialogs().clearLogs(context);
                if(result) {
                    LunaLogger().clearLogs();
                    showLunaSuccessSnackBar(
                        context: context,
                        title: 'Logs Cleared',
                        message: 'All recorded logs have been cleared',
                    );
                }
            },
        );
    }

    Widget _exportLogs() {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Export'),
            subtitle: LunaText.subtitle(text: 'Export All Recorded Logs'),
            trailing: LunaIconButton(icon: Icons.file_download),
            onTap: () async {
                showLunaInfoSnackBar(
                    context: context,
                    title: 'Exporting Logs',
                    message: 'Please wait...',
                );
                File logs = await LunaLogger().exportLogs();
                LunaFileSystem().exportFileToShareSheet(logs.path);
            },
        );
    }
}
