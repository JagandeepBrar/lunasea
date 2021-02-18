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
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar(),
            body: _body(),
        );
    }

    Widget _appBar() {
        return LunaAppBar(
            title: 'Wake on LAN',
            actions: [
                LunaIconButton(
                    icon: Icons.help_outline,
                    onPressed: () async => SettingsDialogs.moduleInformation(context, WakeOnLANConstants.MODULE_METADATA),
                ),
            ],
        );
    }

    Widget _body() {
        return ValueListenableBuilder(
            valueListenable: Database.profilesBox.listenable(),
            builder: (context, box, _) => LunaListView(
                children: [
                    _enabledToggle(),
                    _broadcastAddress(),
                    _macAddress(),
                ],
            ),
        );
    }

    Widget _enabledToggle() {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Enable Wake on LAN'),
            trailing: LunaSwitch(
                value: Database.currentProfileObject.wakeOnLANEnabled ?? false,
                onChanged: (value) {
                    Database.currentProfileObject.wakeOnLANEnabled = value;
                    Database.currentProfileObject.save();
                },
            ),
        );
    }

    Widget _broadcastAddress() {
        String broadcastAddress = Database.currentProfileObject.wakeOnLANBroadcastAddress;
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Broadcast Address'),
            subtitle: LunaText.subtitle(text: broadcastAddress == null || broadcastAddress == '' ? 'Not Set' : broadcastAddress),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async {
                List<dynamic> _values = await SettingsDialogs.editBroadcastAddress(context, broadcastAddress ?? '');
                if(_values[0]) {
                    Database.currentProfileObject.wakeOnLANBroadcastAddress = _values[1];
                    Database.currentProfileObject.save();
                }
            },
        );
    }

    Widget _macAddress() {
        String macAddress = Database.currentProfileObject.wakeOnLANMACAddress;
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Device MAC Address'),
            subtitle: LunaText.subtitle(text: macAddress == null || macAddress == '' ? 'Not Set' : macAddress),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async {
                List<dynamic> _values = await SettingsDialogs.editMACAddress(context, macAddress ?? '');
                if(_values[0]) {
                    Database.currentProfileObject.wakeOnLANMACAddress = _values[1];
                    Database.currentProfileObject.save();
                }
            },
        );
    }
}
