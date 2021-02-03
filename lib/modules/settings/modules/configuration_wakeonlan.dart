import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/modules/wake_on_lan.dart';

class SettingsConfigurationWakeOnLANRouter extends LunaPageRouter {
    SettingsConfigurationWakeOnLANRouter() : super('/settings/configuration/wakeonlan');

    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationWakeOnLANRoute());
}

class _SettingsConfigurationWakeOnLANRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationWakeOnLANRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationWakeOnLANRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Wake on LAN',
        actions: [_helpMessageButton],
    );
    
    Widget get _helpMessageButton => LSIconButton(
        icon: Icons.help_outline,
        onPressed: () async => SettingsDialogs.helpMessage(
            context,
            title: WakeOnLANConstants.MODULE_METADATA.name,
            message: WakeOnLANConstants.MODULE_METADATA.helpMessage,
            github: WakeOnLANConstants.MODULE_METADATA.github,
            website: WakeOnLANConstants.MODULE_METADATA.website,
        ),
    );

    Widget get _body => ValueListenableBuilder(
        valueListenable: Database.profilesBox.listenable(),
        builder: (context, box, _) => LSListView(
            children: [
                ..._configuration,
            ],
        ),
    );

    List<Widget> get _configuration => [
        _enabledTile,
        _broadcastAddressTile,
        _macAddressTile,
    ];

    Widget get _enabledTile => LSCardTile(
        title: LSTitle(text: 'Enable Wake on LAN'),
        trailing: LunaSwitch(
            value: Database.currentProfileObject.wakeOnLANEnabled ?? false,
            onChanged: (value) {
                Database.currentProfileObject.wakeOnLANEnabled = value;
                Database.currentProfileObject.save();
            },
        ),
    );

    Widget get _broadcastAddressTile {
        Future<void> _execute() async {
            List<dynamic> _values = await SettingsDialogs.editBroadcastAddress(context, Database.currentProfileObject.wakeOnLANBroadcastAddress ?? '');
            if(_values[0]) {
                Database.currentProfileObject.wakeOnLANBroadcastAddress = _values[1];
                Database.currentProfileObject.save();
            }
        }
        return LSCardTile(
            title: LSTitle(text: 'Broadcast Address'),
            subtitle: LSSubtitle(
                text: Database.currentProfileObject.wakeOnLANBroadcastAddress == null || Database.currentProfileObject.wakeOnLANBroadcastAddress == ''
                    ? 'Not Set'
                    : Database.currentProfileObject.wakeOnLANBroadcastAddress,
            ),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: _execute,
        );
    }

    Widget get _macAddressTile {
        Future<void> _execute() async {
            List<dynamic> _values = await SettingsDialogs.editMACAddress(context, Database.currentProfileObject.wakeOnLANMACAddress ?? '');
            if(_values[0]) {
                Database.currentProfileObject.wakeOnLANMACAddress = _values[1];
                Database.currentProfileObject.save();
            }
        }
        return LSCardTile(
            title: LSTitle(text: 'Device MAC Address'),
            subtitle: LSSubtitle(
                text: Database.currentProfileObject.wakeOnLANMACAddress == null || Database.currentProfileObject.wakeOnLANMACAddress == ''
                    ? 'Not Set'
                    : Database.currentProfileObject.wakeOnLANMACAddress,
            ),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: _execute,
        );
    }
}
