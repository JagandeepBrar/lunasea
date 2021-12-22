import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationQuickActionsRouter extends SettingsPageRouter {
  SettingsConfigurationQuickActionsRouter()
      : super('/settings/configuration/quickactions');

  @override
  Widget widget() => _Widget();

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
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      scrollControllers: [scrollController],
      title: 'settings.QuickActions'.tr(),
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        SettingsBanners.QUICK_ACTIONS_SUPPORT.banner(),
        _actionTile(
          LunaModule.LIDARR.name,
          LunaDatabaseValue.QUICK_ACTIONS_LIDARR,
        ),
        _actionTile(
          LunaModule.NZBGET.name,
          LunaDatabaseValue.QUICK_ACTIONS_NZBGET,
        ),
        if (kDebugMode)
          _actionTile(
            LunaModule.OVERSEERR.name,
            LunaDatabaseValue.QUICK_ACTIONS_OVERSEERR,
          ),
        _actionTile(
          LunaModule.RADARR.name,
          LunaDatabaseValue.QUICK_ACTIONS_RADARR,
        ),
        _actionTile(
          LunaModule.SABNZBD.name,
          LunaDatabaseValue.QUICK_ACTIONS_SABNZBD,
        ),
        _actionTile(
          LunaModule.SEARCH.name,
          LunaDatabaseValue.QUICK_ACTIONS_SEARCH,
        ),
        _actionTile(
          LunaModule.SONARR.name,
          LunaDatabaseValue.QUICK_ACTIONS_SONARR,
        ),
        _actionTile(
          LunaModule.TAUTULLI.name,
          LunaDatabaseValue.QUICK_ACTIONS_TAUTULLI,
        ),
      ],
    );
  }

  Widget _actionTile(String title, LunaDatabaseValue action) {
    return LunaBlock(
      title: title,
      trailing: ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [action.key]),
        builder: (context, _, __) => LunaSwitch(
            value: action.data,
            onChanged: (value) {
              action.put(value);
              LunaQuickActions().setShortcutItems();
            }),
      ),
    );
  }
}
