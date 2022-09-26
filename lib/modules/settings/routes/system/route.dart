import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/database/database.dart';
import 'package:lunasea/firebase/auth.dart';
import 'package:lunasea/firebase/core.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/modules/settings/routes/system/widgets/backup_tile.dart';
import 'package:lunasea/modules/settings/routes/system/widgets/build_details.dart';
import 'package:lunasea/modules/settings/routes/system/widgets/restore_tile.dart';
import 'package:lunasea/router/routes/settings.dart';
import 'package:lunasea/system/cache/image/image_cache.dart';

class SystemRoute extends StatefulWidget {
  const SystemRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<SystemRoute> createState() => _State();
}

class _State extends State<SystemRoute> with LunaScrollControllerMixin {
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
      onTap: SettingsRoutes.SYSTEM_LOGS.go,
    );
  }

  Widget _clearImageCache() {
    return LunaBlock(
      title: 'Clear Image Cache',
      body: const [TextSpan(text: 'Clear Cached Images From the Disk')],
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
          LunaDatabase().bootstrap();
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
