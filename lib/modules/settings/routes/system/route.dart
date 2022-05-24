import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/firebase/auth.dart';
import 'package:lunasea/firebase/core.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/core/cache/image_cache/image_cache.dart';
import 'package:lunasea/modules/settings/routes/system/widgets/build_details.dart';
import 'package:lunasea/system/build.dart';

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
  final packageInfo = PackageInfo.fromPlatform();
  final checkForUpdates = LunaBuild().checkForUpdates();

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
      title: 'System',
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: <Widget>[
        const BuildDetails(),
        LunaDivider(),
        const SettingsSystemBackupRestoreBackupTile(),
        const SettingsSystemBackupRestoreRestoreTile(),
        LunaDivider(),
        _logs(),
        if (LunaImageCache.isSupported) _clearImageCache(),
        _clearConfiguration(),
      ],
    );
  }

  Widget _logs() {
    return LunaBlock(
      title: 'Logs',
      body: const [TextSpan(text: 'View, Export, and Clear Logs')],
      trailing: const LunaIconButton(icon: Icons.developer_mode_rounded),
      onTap: () async => SettingsSystemLogsRouter().navigateTo(context),
    );
  }

  Widget _clearImageCache() {
    return LunaBlock(
      title: 'Clear Image Cache',
      body: const [TextSpan(text: 'Clear cached images from the disk')],
      trailing: const LunaIconButton(icon: Icons.image_not_supported_rounded),
      onTap: () async {
        bool result = await SettingsDialogs().clearImageCache(context);
        if (result) {
          LunaImageCache().clear();
          showLunaSuccessSnackBar(
            title: 'Image Cache Cleared',
            message: 'Your image cache has been cleared',
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
          Database().bootstrap();
          if (LunaFirebase.isSupported) LunaFirebaseAuth().signOut();
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
