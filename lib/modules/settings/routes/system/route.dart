import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsSystemRouter extends SettingsPageRouter {
  SettingsSystemRouter() : super('/settings/system');

  @override
  _Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) =>
      super.noParameterRouteDefinition(router);
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
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'System',
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: <Widget>[
        _versionInformation(),
        _logs(),
        const LunaDivider(),
        const SettingsSystemBackupRestoreBackupTile(),
        const SettingsSystemBackupRestoreRestoreTile(),
        const LunaDivider(),
        if (kDebugMode) _hideTooltipBanners(),
        _clearConfiguration(),
      ],
    );
  }

  Widget _versionInformation() {
    return FutureBuilder(
        future: PackageInfo.fromPlatform(),
        builder: (context, AsyncSnapshot<PackageInfo> snapshot) {
          String version = 'Loading${LunaUI.TEXT_ELLIPSIS}';
          if (snapshot.hasError) version = 'Unknown';
          if (snapshot.hasData)
            version = '${snapshot.data.version} (${snapshot.data.buildNumber})';
          return LunaBlock(
            title: 'Version: $version',
            body: const [TextSpan(text: 'View Recent Changes')],
            trailing: const LunaIconButton(icon: Icons.system_update_rounded),
            onTap: () async => LunaChangelog().showChangelog(
                snapshot.data?.version, snapshot.data?.buildNumber),
          );
        });
  }

  Widget _logs() {
    return LunaBlock(
      title: 'Logs',
      body: const [TextSpan(text: 'View, Export, and Clear Logs')],
      trailing: const LunaIconButton(icon: Icons.developer_mode_rounded),
      onTap: () async => SettingsSystemLogsRouter().navigateTo(context),
    );
  }

  Widget _hideTooltipBanners() {
    return LunaBlock(
      title: 'Dismiss Tooltip Banners',
      body: const [TextSpan(text: 'Hide Tooltips, Alerts, & Hints')],
      trailing: const LunaIconButton(icon: Icons.rule_rounded),
      onTap: () async {
        bool result = await SettingsDialogs().dismissTooltipBanners(context);
        if (result) {
          for (LunaModule module in LunaModule.values) {
            module.hideAllBanners();
          }
          showLunaSuccessSnackBar(
            title: 'Dismissed Banners',
            message: 'All banners have been dismissed',
          );
        }
      },
    );
  }

  Widget _clearConfiguration() {
    return LunaBlock(
      title: 'Clear Configuration',
      body: const [TextSpan(text: 'Clean Slate')],
      trailing: const LunaIconButton(icon: Icons.delete_sweep_rounded),
      onTap: () async {
        bool result = await SettingsDialogs().clearConfiguration(context);
        if (result) {
          Database().setDefaults(clearEverything: true);
          LunaFirebaseAuth().signOut();
          LunaState.reset(context);
          showLunaSuccessSnackBar(
            title: 'Configuration Cleared',
            message: 'Your configuration has been cleared',
          );
        }
      },
    );
  }
}
