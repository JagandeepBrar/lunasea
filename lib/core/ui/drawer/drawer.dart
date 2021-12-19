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
            builder: (context, _, __) => Column(
              children: [
                LunaDrawerHeader(),
                Expanded(
                  child: LunaListView(
                    controller: PrimaryScrollController.of(context),
                    children: LunaDatabaseValue.DRAWER_AUTOMATIC_MANAGE.data
                        ? _getAlphabeticalOrder(context)
                        : _getManualOrder(context),
                    physics: const ClampingScrollPhysics(),
                    padding: MediaQuery.of(context)
                        .padding
                        .copyWith(top: LunaUI.MARGIN_SIZE_HALF),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _sharedHeader(BuildContext context) {
    return [
      _buildEntry(
        context: context,
        module: LunaModule.DASHBOARD,
        showDescription: false,
      ),
      _buildEntry(
        context: context,
        module: LunaModule.SETTINGS,
        showDescription: false,
      ),
      const LunaDivider(),
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
    bool showDescription = true,
  }) {
    bool currentPage = page == module.key.toLowerCase();
    return LunaBlock(
      leading: LunaIconButton(
        icon: module.icon,
        color: currentPage ? module.color : Colors.white,
      ),
      title: module.name,
      body: showDescription ? [TextSpan(text: module.description)] : [],
      titleColor: currentPage ? module.color : Colors.white,
      onTap: () async {
        Navigator.of(context).pop();
        if (!currentPage) module.launch();
      },
    );
  }

  Widget _buildWakeOnLAN(BuildContext context) {
    return LunaBlock(
      leading: LunaIconButton(icon: LunaModule.WAKE_ON_LAN.icon),
      title: LunaModule.WAKE_ON_LAN.name,
      // body: [TextSpan(text: LunaModule.WAKE_ON_LAN.description)],
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
    );
  }
}
