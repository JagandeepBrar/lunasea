import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/wake_on_lan.dart';

class LunaDrawer extends StatelessWidget {
  final String page;

  const LunaDrawer({
    Key key,
    @required this.page,
  }) : super(key: key);

  static List<LunaModule> moduleOrderedList() {
    LunaDatabaseValue dbValue = LunaDatabaseValue.DRAWER_MANUAL_ORDER;
    List<LunaModule> _modules = (dbValue.data as List)?.cast<LunaModule>();
    // Add any modules that were added after the user set their drawer order preference
    _modules?.addAll(
      LunaModule.DASHBOARD.allModules()
        ..retainWhere(
          (module) => !_modules.contains(module),
        ),
    );
    _modules ??= LunaModule.DASHBOARD.allModules();
    return _modules;
  }

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
              padding: const EdgeInsets.only(bottom: 8.0),
              physics: const ClampingScrollPhysics(),
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
      const Divider(
        thickness: 1.0,
        color: LunaColours.white10,
      ),
    ];
  }

  List<Widget> _getAlphabeticalOrder(BuildContext context) {
    List<LunaModule> _modules = LunaModule.DASHBOARD.allModules()
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
        return const SizedBox(height: 0.0);
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
        return const SizedBox(height: 0.0);
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
        color: currentPage ? module.color : Colors.white,
      ),
      title: Text(
        module.name,
        style: TextStyle(
          color: currentPage ? module.color : Colors.white,
          fontSize: LunaUI.FONT_SIZE_H3,
        ),
      ),
      onTap: () async {
        Navigator.of(context).pop();
        if (!currentPage) module.launch();
      },
      contentPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
    );
  }

  Widget _buildWakeOnLAN(BuildContext context) {
    return ListTile(
      leading: Icon(LunaModule.WAKE_ON_LAN.icon),
      title: Text(
        LunaModule.WAKE_ON_LAN.name,
        style: const TextStyle(
          color: Colors.white,
          fontSize: LunaUI.FONT_SIZE_H3,
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
      contentPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
    );
  }
}
