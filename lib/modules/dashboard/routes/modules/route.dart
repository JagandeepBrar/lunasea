import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/dashboard.dart';

class DashboardModulesRoute extends StatefulWidget {
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
    if (!(Database.indexersBox.length > 0) &&
        !(Database.currentProfileObject.anythingEnabled)) {
      return LunaMessage(
        text: 'lunasea.NoModulesEnabled'.tr(),
        buttonText: 'lunasea.GoToSettings'.tr(),
        onTap: LunaModule.SETTINGS.launch,
      );
    }
    return _buildList();
  }

  Widget _buildList() {
    List<Widget> modules = [];
    int index = 0;
    // Build list of all modules
    if (Database.indexersBox.length > 0) {
      modules.add(_buildFromLunaModule(LunaModule.SEARCH, index));
      index++;
    }
    Database.currentProfileObject.enabledAutomationModules.forEach((module) {
      modules.add(_buildFromLunaModule(module, index));
      index++;
    });
    Database.currentProfileObject.enabledClientModules.forEach((module) {
      modules.add(_buildFromLunaModule(module, index));
      index++;
    });
    Database.currentProfileObject.enabledMonitoringModules.forEach((module) {
      modules.add(_buildFromLunaModule(module, index));
      index++;
    });
    modules.add(_buildFromLunaModule(LunaModule.SETTINGS, index));
    // Build that listview
    return LunaListView(
      controller: DashboardNavigationBar.scrollControllers[0],
      children: modules,
    );
  }

  Widget _buildFromLunaModule(LunaModule module, int listIndex) {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: module.name),
      subtitle: LunaText.subtitle(text: module.description),
      trailing: LunaIconButton(
        icon: module.icon,
        color: DashboardDatabaseValue.MODULES_BRAND_COLOURS.data
            ? module.color
            : LunaColours().byListIndex(listIndex),
      ),
      onTap: module.launch,
    );
  }
}
