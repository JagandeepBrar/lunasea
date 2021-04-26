import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/wake_on_lan.dart';

class LunaDrawer extends StatelessWidget {
  final String page;

  LunaDrawer({
    @required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return LunaDatabaseValue.ENABLED_PROFILE.listen(
      builder: (context, lunaBox, widget) => ValueListenableBuilder(
        valueListenable: Database.indexersBox.listenable(),
        builder: (context, indexerBox, widget) => Drawer(
          child: ListView(
            children: _getDrawerEntries(context),
            padding: EdgeInsets.only(bottom: 8.0),
            physics: ClampingScrollPhysics(),
          ),
        ),
      ),
    );
  }

  List<Widget> _getDrawerEntries(BuildContext context) {
    List<LunaModule> _modules = LunaModule.DASHBOARD.enabledExternalModules();
    return <Widget>[
      LunaDrawerHeader(),
      _buildEntry(context: context, module: LunaModule.DASHBOARD),
      _buildEntry(context: context, module: LunaModule.SETTINGS),
      LunaDivider(),
      ..._modules.map((module) {
        if (module.isGloballyEnabled && module.isProfileEnabled) {
          if (module == LunaModule.WAKE_ON_LAN) return _buildWakeOnLAN(context);
          return _buildEntry(
            context: context,
            module: module,
          );
        }
        return SizedBox(height: 0.0);
      }),
    ];
  }

  Widget _buildEntry({
    @required BuildContext context,
    @required LunaModule module,
  }) {
    bool currentPage = page == module.key.toLowerCase();
    return ListTile(
      leading: Icon(
        module.icon,
        color: currentPage ? LunaColours.accent : Colors.white,
      ),
      title: Text(
        module.name,
        style: TextStyle(
          color: currentPage ? LunaColours.accent : Colors.white,
          fontSize: LunaUI.FONT_SIZE_SUBTITLE,
        ),
      ),
      onTap: () async {
        Navigator.of(context).pop();
        if (!currentPage) module.launch();
      },
      contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
    );
  }

  Widget _buildWakeOnLAN(BuildContext context) {
    return ListTile(
      leading: Icon(LunaModule.WAKE_ON_LAN.icon),
      title: Text(
        LunaModule.WAKE_ON_LAN.name,
        style: TextStyle(
          color: Colors.white,
          fontSize: LunaUI.FONT_SIZE_SUBTITLE,
        ),
      ),
      onTap: () async {
        WakeOnLANAPI api = WakeOnLANAPI.fromProfile();
        await api
            .wake()
            .then((_) => showLunaSuccessSnackBar(
                  title: 'Machine is Waking Up...',
                  message: 'Magic packet successfully sent',
                ))
            .catchError((error, stack) {
          LunaLogger().error('Failed to wake machine', error, stack);
          return showLunaErrorSnackBar(
            title: 'Failed to Wake Machine',
            error: error,
          );
        });
      },
      contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
    );
  }
}
