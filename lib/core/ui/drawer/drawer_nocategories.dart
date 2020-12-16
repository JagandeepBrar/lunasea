import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/main.dart';
import 'package:lunasea/modules/wake_on_lan.dart';

class LSDrawerNoCategories extends StatelessWidget {
    final String page;

    LSDrawerNoCategories({
        @required this.page,
    });

    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [LunaSeaDatabaseValue.ENABLED_PROFILE.key]),
        builder: (context, lunaBox, widget) {
            return ValueListenableBuilder(
                valueListenable: Database.indexersBox.listenable(),
                builder: (context, indexerBox, widget) {
                    ProfileHiveObject profile = Database.profilesBox.get(lunaBox.get(LunaSeaDatabaseValue.ENABLED_PROFILE.key));
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
                icon: CustomIcons.home,
                title: 'Home',
                route: '/',
            ),
            _buildEntry(
                context: context,
                icon: CustomIcons.settings,
                title: 'Settings',
                route: '/settings',
            ),
            LSDivider(),
            if(showIndexerSearch) _buildEntry(
                context: context,
                icon: Icons.search,
                title: 'Search',
                route: '/search',
            ),
            if(profile.getWakeOnLAN()['enabled']) _buildWakeOnLAN(context: context),
            ...List.generate(
                Database.currentProfileObject.enabledAutomationModules.length,
                (index) => _buildEntry(
                    context: context,
                    route: Constants.MODULE_METADATA[Database.currentProfileObject.enabledAutomationModules[index]].route,
                    icon: Constants.MODULE_METADATA[Database.currentProfileObject.enabledAutomationModules[index]].icon,
                    title: Constants.MODULE_METADATA[Database.currentProfileObject.enabledAutomationModules[index]].name,
                ),
            ),
            ...List.generate(
                Database.currentProfileObject.enabledClientModules.length,
                (index) => _buildEntry(
                    context: context,
                    route: Constants.MODULE_METADATA[Database.currentProfileObject.enabledClientModules[index]].route,
                    icon: Constants.MODULE_METADATA[Database.currentProfileObject.enabledClientModules[index]].icon,
                    title: Constants.MODULE_METADATA[Database.currentProfileObject.enabledClientModules[index]].name,
                ),
            ),
            ...List.generate(
                Database.currentProfileObject.enabledMonitoringModules.length,
                (index) => _buildEntry(
                    context: context,
                    route: Constants.MODULE_METADATA[Database.currentProfileObject.enabledMonitoringModules[index]].route,
                    icon: Constants.MODULE_METADATA[Database.currentProfileObject.enabledMonitoringModules[index]].icon,
                    title: Constants.MODULE_METADATA[Database.currentProfileObject.enabledMonitoringModules[index]].name,
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
                if(!currentPage) LunaBIOS.navigatorKey.currentState.pushNamedAndRemoveUntil(route, (Route<dynamic> route) => false);
            },
            contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
        );
    }

    Widget _buildWakeOnLAN({
        @required BuildContext context,
    }) {
        return ListTile(
            leading: LSIcon(icon: Constants.MODULE_METADATA[WakeOnLANConstants.MODULE_KEY].icon),
            title: Text(
                Constants.MODULE_METADATA[WakeOnLANConstants.MODULE_KEY].name,
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