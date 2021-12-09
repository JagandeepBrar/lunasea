import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/dashboard.dart';
import 'package:lunasea/modules/wake_on_lan.dart';

class DashboardModulesRoute extends StatefulWidget {
  const DashboardModulesRoute({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<DashboardModulesRoute>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      body: _list(),
    );
  }

  Widget _list() {
    if (!(Database.currentProfileObject.anythingEnabled)) {
      return LunaMessage(
        text: 'lunasea.NoModulesEnabled'.tr(),
        buttonText: 'lunasea.GoToSettings'.tr(),
        onTap: LunaModule.SETTINGS.launch,
      );
    }
    return LunaListView(
      controller: DashboardNavigationBar.scrollControllers[0],
      itemExtent: LunaListTile.extentFromSubtitleLines(1),
      children: LunaDatabaseValue.DRAWER_AUTOMATIC_MANAGE.data
          ? _buildAlphabeticalList()
          : _buildManuallyOrderedList(),
    );
  }

  List<Widget> _buildAlphabeticalList() {
    List<Widget> modules = [];
    int index = 0;
    LunaModule.DASHBOARD.allModules()
      ..sort((a, b) => a.name.toLowerCase().compareTo(
            b.name.toLowerCase(),
          ))
      ..forEach((module) {
        if (module.isEnabled) {
          if (module == LunaModule.WAKE_ON_LAN) {
            modules.add(_buildWakeOnLAN(context, index));
          } else {
            modules.add(_buildFromLunaModule(module, index));
          }
          index++;
        }
      });
    modules.add(_buildFromLunaModule(LunaModule.SETTINGS, index));
    return modules;
  }

  List<Widget> _buildManuallyOrderedList() {
    List<Widget> modules = [];
    int index = 0;
    LunaDrawer.moduleOrderedList().forEach((module) {
      if (module.isEnabled) {
        if (module == LunaModule.WAKE_ON_LAN) {
          modules.add(_buildWakeOnLAN(context, index));
        } else {
          modules.add(_buildFromLunaModule(module, index));
        }
        index++;
      }
    });
    modules.add(_buildFromLunaModule(LunaModule.SETTINGS, index));
    return modules;
  }

  Widget _buildFromLunaModule(LunaModule module, int listIndex) {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: module.name),
      subtitle: LunaText.subtitle(text: module.description),
      trailing: LunaIconButton(icon: module.icon, color: module.color),
      onTap: module.launch,
    );
  }

  Widget _buildWakeOnLAN(BuildContext context, int listIndex) {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: LunaModule.WAKE_ON_LAN.name),
      subtitle: LunaText.subtitle(text: LunaModule.WAKE_ON_LAN.description),
      trailing: LunaIconButton(
        icon: LunaModule.WAKE_ON_LAN.icon,
        color: LunaModule.WAKE_ON_LAN.color,
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
    );
  }
}
