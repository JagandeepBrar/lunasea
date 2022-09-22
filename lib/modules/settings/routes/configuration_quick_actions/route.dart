import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/system/quick_actions/quick_actions.dart';

class ConfigurationQuickActionsRoute extends StatefulWidget {
  const ConfigurationQuickActionsRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationQuickActionsRoute> createState() => _State();
}

class _State extends State<ConfigurationQuickActionsRoute>
    with LunaScrollControllerMixin {
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
          LunaModule.LIDARR.title,
          LunaSeaDatabase.QUICK_ACTIONS_LIDARR,
        ),
        _actionTile(
          LunaModule.NZBGET.title,
          LunaSeaDatabase.QUICK_ACTIONS_NZBGET,
        ),
        if (LunaModule.OVERSEERR.featureFlag)
          _actionTile(
            LunaModule.OVERSEERR.title,
            LunaSeaDatabase.QUICK_ACTIONS_OVERSEERR,
          ),
        _actionTile(
          LunaModule.RADARR.title,
          LunaSeaDatabase.QUICK_ACTIONS_RADARR,
        ),
        _actionTile(
          LunaModule.SABNZBD.title,
          LunaSeaDatabase.QUICK_ACTIONS_SABNZBD,
        ),
        _actionTile(
          LunaModule.SEARCH.title,
          LunaSeaDatabase.QUICK_ACTIONS_SEARCH,
        ),
        _actionTile(
          LunaModule.SONARR.title,
          LunaSeaDatabase.QUICK_ACTIONS_SONARR,
        ),
        _actionTile(
          LunaModule.TAUTULLI.title,
          LunaSeaDatabase.QUICK_ACTIONS_TAUTULLI,
        ),
      ],
    );
  }

  Widget _actionTile(String title, LunaSeaDatabase action) {
    return LunaBlock(
      title: title,
      trailing: LunaBox.lunasea.listenableBuilder(
        selectKeys: [action.key],
        builder: (context, _) => LunaSwitch(
          value: action.read(),
          onChanged: (value) {
            action.update(value);
            if (LunaQuickActions.isSupported)
              LunaQuickActions().setActionItems();
          },
        ),
      ),
    );
  }
}
