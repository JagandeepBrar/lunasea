import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/main.dart';
import 'package:lunasea/modules/wake_on_lan.dart';

class LSDrawer extends StatelessWidget {
    final String page;

    LSDrawer({
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

    Widget get _header => UserAccountsDrawerHeader(
        accountName: LSTitle(text: Constants.APPLICATION_NAME),
        accountEmail: ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [LunaSeaDatabaseValue.ENABLED_PROFILE.key]),
            builder: (context, lunaBox, widget) => ValueListenableBuilder(
                valueListenable: Database.profilesBox.listenable(),
                builder: (context, profilesBox, widget) => Padding(
                    child: PopupMenuButton<String>(
                        shape: LunaSeaDatabaseValue.THEME_AMOLED.data && LunaSeaDatabaseValue.THEME_AMOLED_BORDER.data
                            ? LSRoundedShapeWithBorder()
                            : LSRoundedShape(),
                        child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                                LSSubtitle(
                                    text: LunaSeaDatabaseValue.ENABLED_PROFILE.data,
                                ),
                                LSIcon(
                                    icon: Icons.arrow_drop_down,
                                    color: Colors.white70,
                                    size: Constants.UI_FONT_SIZE_HEADER,
                                ),
                            ],
                        ),
                        onSelected: (result) {
                            LunaSeaDatabaseValue.ENABLED_PROFILE.put(result);
                            Providers.reset(context);
                            LSSnackBar(
                                context: context,
                                title: 'Changed Profile',
                                message: 'Using profile "$result"',
                                type: SNACKBAR_TYPE.info,
                            );
                        },
                        itemBuilder: (context) {
                            return <PopupMenuEntry<String>>[for(String profile in (profilesBox as Box).keys) PopupMenuItem<String>(
                                value: profile,
                                child: Text(
                                    profile,
                                    style: TextStyle(
                                        fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                                    ),
                                ),
                            )];
                        },
                    ),
                    padding: EdgeInsets.only(right: 12.0),
                ),
            ),
        ),
        decoration: BoxDecoration(
            color: LSColors.accent,
            image: DecorationImage(
                image: AssetImage('assets/branding/icon_drawer.png'),
                colorFilter: ColorFilter.mode(LSColors.primary.withOpacity(0.15), BlendMode.dstATop),
                fit: BoxFit.cover,
            ),
        ),
    );

    List<Widget> _getDrawerEntries(BuildContext context, ProfileHiveObject profile, bool showIndexerSearch) {
        return <Widget>[
            _header,
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
                justPush: true,
            ),
            LSDivider(),
            if(showIndexerSearch) _buildEntry(
                context: context,
                icon: Icons.search,
                title: 'Search',
                route: '/search',
            ),
            if(profile.getWakeOnLAN()['enabled']) _buildWakeOnLAN(context: context),
            if(profile.anyAutomationEnabled) ExpansionTile(
                leading: Icon(CustomIcons.layers),
                title: Text(
                    'Automation',
                    style: TextStyle(
                        fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                    ),
                ),
                initiallyExpanded: LunaSeaDatabaseValue.DRAWER_EXPAND_AUTOMATION.data,
                children: List.generate(
                    Database.currentProfileObject.enabledAutomationModules.length,
                    (index) => _buildEntry(
                        context: context,
                        route: Constants.MODULE_MAP[Database.currentProfileObject.enabledAutomationModules[index]].route,
                        icon: Constants.MODULE_MAP[Database.currentProfileObject.enabledAutomationModules[index]].icon,
                        title: Constants.MODULE_MAP[Database.currentProfileObject.enabledAutomationModules[index]].name,
                        padLeft: true,
                    ),
                ),
            ),
            if(profile.anyClientsEnabled) ExpansionTile(
                leading: Icon(CustomIcons.clients),
                title: Text(
                    'Clients',
                    style: TextStyle(
                        fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                    ),
                ),
                initiallyExpanded: LunaSeaDatabaseValue.DRAWER_EXPAND_CLIENTS.data,
                children: List.generate(
                    Database.currentProfileObject.enabledClientModules.length,
                    (index) => _buildEntry(
                        context: context,
                        route: Constants.MODULE_MAP[Database.currentProfileObject.enabledClientModules[index]].route,
                        icon: Constants.MODULE_MAP[Database.currentProfileObject.enabledClientModules[index]].icon,
                        title: Constants.MODULE_MAP[Database.currentProfileObject.enabledClientModules[index]].name,
                        padLeft: true,
                    ),
                ),
            ),
            if(profile.anyMonitoringEnabled) ExpansionTile(
                leading: Icon(CustomIcons.monitoring),
                title: Text(
                    'Monitoring',
                    style: TextStyle(
                        fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                    ),
                ),
                initiallyExpanded: LunaSeaDatabaseValue.DRAWER_EXPAND_MONITORING.data,
                children: List.generate(
                    Database.currentProfileObject.enabledMonitoringModules.length,
                    (index) => _buildEntry(
                        context: context,
                        route: Constants.MODULE_MAP[Database.currentProfileObject.enabledMonitoringModules[index]].route,
                        icon: Constants.MODULE_MAP[Database.currentProfileObject.enabledMonitoringModules[index]].icon,
                        title: Constants.MODULE_MAP[Database.currentProfileObject.enabledMonitoringModules[index]].name,
                        padLeft: true,
                    ),
                ),
            ),
        ];
    }

    Widget _buildEntry({
        @required BuildContext context,
        @required IconData icon,
        @required String title,
        @required String route,
        bool justPush = false,
        bool padLeft = false,
    }) {
        bool currentPage = page == title.toLowerCase();
        return ListTile(
            leading: LSIcon(
                icon: icon,
                color: currentPage ? LSColors.accent : Colors.white,
            ),
            title: Text(
                title,
                style: TextStyle(
                    color: currentPage
                        ? LSColors.accent
                        : Colors.white,
                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                ),
            ),
            onTap: () async {
                Navigator.of(context).pop();
                if(!currentPage) {
                    justPush
                        ? await BIOS.navigatorKey.currentState.pushNamed(route)
                        : await BIOS.navigatorKey.currentState.pushNamedAndRemoveUntil(route, (Route<dynamic> route) => false);
                }
            },
            contentPadding: padLeft
                ? EdgeInsets.fromLTRB(42.0, 0.0, 0.0, 0.0)
                : EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
        );
    }

    Widget _buildWakeOnLAN({
        @required BuildContext context,
    }) {
        return ListTile(
            leading: LSIcon(icon: Constants.MODULE_MAP[WakeOnLANConstants.MODULE_KEY].icon),
            title: Text(
                Constants.MODULE_MAP[WakeOnLANConstants.MODULE_KEY].name,
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