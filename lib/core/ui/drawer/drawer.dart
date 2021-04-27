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
          child: LunaDatabaseValue.DRAWER_AUTOMATIC_MANAGE.listen(
            builder: (context, _, __) => ListView(
              children: LunaDatabaseValue.DRAWER_AUTOMATIC_MANAGE.data
                  ? _getAlphabeticalOrder(context)
                  : _getManualOrder(context),
              padding: EdgeInsets.only(bottom: 8.0),
              physics: ClampingScrollPhysics(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _sharedHeader(BuildContext context) {
    return [
      LunaDrawerHeader(),
      _buildEntry(context: context, module: LunaModule.DASHBOARD),
      _buildEntry(context: context, module: LunaModule.SETTINGS),
      LunaDivider(),
    ];
  }

  List<Widget> _getAlphabeticalOrder(BuildContext context) {
    List<LunaModule> _modules = LunaModule.DASHBOARD.allExternalModules()
      ..sort((a, b) => a.name.toLowerCase().compareTo(
            b.name.toLowerCase(),
          ));
    return <Widget>[
      ..._sharedHeader(context),
      ..._modules.map((module) {
        if (module.isEnabled) {
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

  List<Widget> _getManualOrder(BuildContext context) {
    List<LunaModule> _modules = moduleOrderedList();
    return <Widget>[
      ..._sharedHeader(context),
      ..._modules.map((module) {
        if (module.isEnabled) {
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

  static List<LunaModule> moduleOrderedList() {
    LunaDatabaseValue dbValue = LunaDatabaseValue.DRAWER_MANUAL_ORDER;
    List<LunaModule> _modules = (dbValue.data as List)?.cast<LunaModule>();
    _modules ??= LunaModule.DASHBOARD.allExternalModules();
    // Add any modules that were added after the user set their drawer order preference
    _modules.addAll(
      LunaModule.DASHBOARD.allExternalModules()
        ..retainWhere(
          (module) => !_modules.contains(module),
        ),
    );
    return _modules;
  }
}
