import 'package:flutter/material.dart';

import 'package:lunasea/modules.dart';
import 'package:lunasea/database/models/profile.dart';
import 'package:lunasea/database/tables/lunasea.dart';
import 'package:lunasea/vendor.dart';
import 'package:lunasea/widgets/ui.dart';
import 'package:lunasea/api/wake_on_lan/wake_on_lan.dart';
import 'package:lunasea/modules/dashboard/routes/dashboard/widgets/navigation_bar.dart';

class ModulesPage extends StatefulWidget {
  const ModulesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ModulesPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _list();
  }

  Widget _list() {
    if (!(LunaProfile.current.isAnythingEnabled())) {
      return LunaMessage(
        text: 'lunasea.NoModulesEnabled'.tr(),
        buttonText: 'lunasea.GoToSettings'.tr(),
        onTap: LunaModule.SETTINGS.launch,
      );
    }
    return LunaListView(
      controller: HomeNavigationBar.scrollControllers[0],
      itemExtent: LunaBlock.calculateItemExtent(1),
      children: LunaSeaDatabase.DRAWER_AUTOMATIC_MANAGE.read()
          ? _buildAlphabeticalList()
          : _buildManuallyOrderedList(),
    );
  }

  List<Widget> _buildAlphabeticalList() {
    List<Widget> modules = [];
    int index = 0;
    LunaModule.active
      ..sort((a, b) => a.title.toLowerCase().compareTo(
            b.title.toLowerCase(),
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
    return LunaBlock(
      title: module.title,
      body: [TextSpan(text: module.description)],
      trailing: LunaIconButton(icon: module.icon, color: module.color),
      onTap: module.launch,
    );
  }

  Widget _buildWakeOnLAN(BuildContext context, int listIndex) {
    return LunaBlock(
      title: LunaModule.WAKE_ON_LAN.title,
      body: [TextSpan(text: LunaModule.WAKE_ON_LAN.description)],
      trailing: LunaIconButton(
        icon: LunaModule.WAKE_ON_LAN.icon,
        color: LunaModule.WAKE_ON_LAN.color,
      ),
      onTap: () async => LunaWakeOnLAN().wake(),
    );
  }
}
