import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/api/wake_on_lan/wake_on_lan.dart';

class LunaDrawer extends StatelessWidget {
  final String page;

  const LunaDrawer({
    Key? key,
    required this.page,
  }) : super(key: key);

  static List<LunaModule> moduleAlphabeticalList() {
    return LunaModule.active
      ..sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
  }

  static List<LunaModule> moduleOrderedList() {
    try {
      const db = LunaSeaDatabase.DRAWER_MANUAL_ORDER;
      final modules = List.from(db.read());
      final missing = LunaModule.active;

      missing.retainWhere((m) => !modules.contains(m));
      modules.addAll(missing);
      modules.retainWhere((m) => (m as LunaModule).featureFlag);

      return modules.cast<LunaModule>();
    } catch (error, stack) {
      LunaLogger().error('Failed to create ordered module list', error, stack);
      return moduleAlphabeticalList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LunaSeaDatabase.ENABLED_PROFILE.listenableBuilder(
      builder: (context, _) => LunaBox.indexers.listenableBuilder(
        builder: (context, _) => Drawer(
          elevation: LunaUI.ELEVATION,
          backgroundColor: Theme.of(context).primaryColor,
          child: LunaSeaDatabase.DRAWER_AUTOMATIC_MANAGE.listenableBuilder(
            builder: (context, _) => Column(
              children: [
                LunaDrawerHeader(page: page),
                Expanded(
                  child: LunaListView(
                    controller: PrimaryScrollController.of(context),
                    children: _moduleList(
                      context,
                      LunaSeaDatabase.DRAWER_AUTOMATIC_MANAGE.read()
                          ? moduleAlphabeticalList()
                          : moduleOrderedList(),
                    ),
                    physics: const ClampingScrollPhysics(),
                    padding: MediaQuery.of(context).padding.copyWith(top: 0),
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
      ),
    ];
  }

  List<Widget> _moduleList(BuildContext context, List<LunaModule> modules) {
    return <Widget>[
      ..._sharedHeader(context),
      ...modules.map((module) {
        if (module.isEnabled) {
          return _buildEntry(
            context: context,
            module: module,
            onTap: module == LunaModule.WAKE_ON_LAN ? _wakeOnLAN : null,
          );
        }
        return const SizedBox(height: 0.0);
      }),
    ];
  }

  Widget _buildEntry({
    required BuildContext context,
    required LunaModule module,
    void Function()? onTap,
  }) {
    bool currentPage = page == module.key.toLowerCase();
    return SizedBox(
      height: LunaTextInputBar.defaultAppBarHeight,
      child: InkWell(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              child: Icon(
                module.icon,
                color: currentPage ? module.color : LunaColours.white,
              ),
              padding: LunaUI.MARGIN_DEFAULT_HORIZONTAL * 1.5,
            ),
            Text(
              module.title,
              style: TextStyle(
                color: currentPage ? module.color : LunaColours.white,
                fontWeight: LunaUI.FONT_WEIGHT_BOLD,
              ),
            ),
          ],
        ),
        onTap: onTap ??
            () async {
              Navigator.of(context).pop();
              if (!currentPage) module.launch();
            },
      ),
    );
  }

  Future<void> _wakeOnLAN() async => LunaWakeOnLAN().wake();
}
