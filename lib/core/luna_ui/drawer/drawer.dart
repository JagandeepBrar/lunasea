import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/wake_on_lan.dart';

class LunaDrawer extends StatelessWidget {
    final String page;

    LunaDrawer({
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
            LunaDrawerHeader(),
            _buildEntry(context: context, module: LunaModule.DASHBOARD),
            _buildEntry(context: context, module: LunaModule.SETTINGS),
            LSDivider(),
            if(showIndexerSearch) _buildEntry(context: context, module: LunaModule.SEARCH),
            if(LunaModule.WAKE_ON_LAN.enabled) _buildWakeOnLAN(context),
            ...List.generate(
                Database.currentProfileObject.enabledAutomationModules.length,
                (index) => _buildEntry(context: context, module: Database.currentProfileObject.enabledAutomationModules[index]),
            ),
            ...List.generate(
                Database.currentProfileObject.enabledClientModules.length,
                (index) => _buildEntry(context: context, module: Database.currentProfileObject.enabledClientModules[index]),
            ),
            ...List.generate(
                Database.currentProfileObject.enabledMonitoringModules.length,
                (index) => _buildEntry(context: context, module: Database.currentProfileObject.enabledMonitoringModules[index]),
            ),
        ];
    }

    Widget _buildEntry({
        @required BuildContext context,
        @required LunaModule module,
    }) {
        bool currentPage = page == module.key.toLowerCase();
        return ListTile(
            leading: LSIcon(
                icon: module.icon,
                color: currentPage ? LunaColours.accent : Colors.white,
            ),
            title: Text(
                module.name,
                style: TextStyle(
                    color: currentPage
                        ? LunaColours.accent
                        : Colors.white,
                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                ),
            ),
            onTap: () async {
                Navigator.of(context).pop();
                if(!currentPage) module.launch();
            },
            contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
        );
    }

    Widget _buildWakeOnLAN(BuildContext context) {
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
                WakeOnLANAPI api = WakeOnLANAPI.fromProfile();
                await api.wake()
                .then((_) => showLunaSuccessSnackBar(
                    context: context,
                    title: 'Machine is Waking Up...',
                    message: 'Magic packet successfully sent',
                ))
                .catchError((error, stack) {
                    LunaLogger().error('Failed to wake machine', error, stack);
                    return showLunaErrorSnackBar(
                        context: context,
                        title: 'Failed to Wake Machine',
                        error: error,
                    );
                });
            },
            contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
        );
    }
}
