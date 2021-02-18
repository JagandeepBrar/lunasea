import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/wake_on_lan.dart';

class LSDrawer extends StatelessWidget {
    final String page;

    LSDrawer({
        @required this.page,
    });

    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [LunaDatabaseValue.ENABLED_PROFILE.key]),
        builder: (context, lunaBox, widget) {
            return ValueListenableBuilder(
                valueListenable: Database.indexersBox.listenable(),
                builder: (context, indexerBox, widget) {
                    ProfileHiveObject profile = Database.profilesBox.get(lunaBox.get(LunaDatabaseValue.ENABLED_PROFILE.key));
                    return Drawer(
                        child: ListView(
                            children: _getDrawerEntries(context, profile, (indexerBox as Box).length > 0),
                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
                            physics: ClampingScrollPhysics(),
                        ),
                    );
                }
            );
        }
    );

    List<Widget> _getDrawerEntries(BuildContext context, ProfileHiveObject profile, bool showIndexerSearch) {
        return <Widget>[
            LSDrawerHeader(),
            _buildEntry(
                context: context,
                icon: LunaModule.DASHBOARD.icon,
                title: LunaModule.DASHBOARD.name,
                route: LunaModule.DASHBOARD.route,
            ),
            _buildEntry(
                context: context,
                icon: LunaModule.SETTINGS.icon,
                title: LunaModule.SETTINGS.name,
                route: LunaModule.SETTINGS.route,
            ),
            LSDivider(),
            if(showIndexerSearch) _buildEntry(
                context: context,
                icon: LunaModule.SEARCH.icon,
                title: LunaModule.SEARCH.name,
                route: LunaModule.SEARCH.route,
            ),
            if(LunaModule.WAKE_ON_LAN.enabled) _buildWakeOnLAN(context: context),
            ...List.generate(
                Database.currentProfileObject.enabledAutomationModules.length,
                (index) => _buildEntry(
                    context: context,
                    route: Database.currentProfileObject.enabledAutomationModules[index].route,
                    icon: Database.currentProfileObject.enabledAutomationModules[index].icon,
                    title: Database.currentProfileObject.enabledAutomationModules[index].name,
                ),
            ),
            ...List.generate(
                Database.currentProfileObject.enabledClientModules.length,
                (index) => _buildEntry(
                    context: context,
                    route: Database.currentProfileObject.enabledAutomationModules[index].route,
                    icon: Database.currentProfileObject.enabledAutomationModules[index].icon,
                    title: Database.currentProfileObject.enabledAutomationModules[index].name,
                ),
            ),
            ...List.generate(
                Database.currentProfileObject.enabledMonitoringModules.length,
                (index) => _buildEntry(
                    context: context,
                    route: Database.currentProfileObject.enabledAutomationModules[index].route,
                    icon: Database.currentProfileObject.enabledAutomationModules[index].icon,
                    title: Database.currentProfileObject.enabledAutomationModules[index].name,
                ),
            ),
        ];
    }

    Widget _buildEntry({
        @required BuildContext context,
        @required IconData icon,
        @required String title,
        @required String route,
    }) {
        bool currentPage = page == title.toLowerCase();
        return ListTile(
            leading: LSIcon(
                icon: icon,
                color: currentPage ? LunaColours.accent : Colors.white,
            ),
            title: Text(
                title,
                style: TextStyle(
                    color: currentPage
                        ? LunaColours.accent
                        : Colors.white,
                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                ),
            ),
            onTap: () async {
                Navigator.of(context).pop();
                if(!currentPage) LunaState.navigatorKey.currentState.pushNamedAndRemoveUntil(route, (Route<dynamic> route) => false);
            },
            contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
        );
    }

    Widget _buildWakeOnLAN({
        @required BuildContext context,
    }) {
        return ListTile(
            leading: LSIcon(icon: LunaModule.WAKE_ON_LAN.icon),
            title: Text(
                LunaModule.WAKE_ON_LAN.name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                ),
            ),
            onTap: () async {
                WakeOnLANAPI _api = WakeOnLANAPI.from(Database.currentProfileObject);
                await _api.wake()
                .then((_) => LSSnackBar(
                    context: context,
                    title: 'Machine is Waking Up...',
                    message: 'Magic packet successfully sent',
                    type: SNACKBAR_TYPE.success,
                ))
                .catchError((_) => LSSnackBar(
                    context: context,
                    title: 'Failed to Wake Machine',
                    message: 'Magic packet failed to send',
                    type: SNACKBAR_TYPE.failure,
                ));
            },
            contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
        );
    }
}