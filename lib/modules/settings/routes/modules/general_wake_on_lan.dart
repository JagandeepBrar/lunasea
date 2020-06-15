import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesWakeOnLAN extends StatefulWidget {
    static const ROUTE_NAME = '/settings/modules/wakeonlan';
    
    @override
    State<SettingsModulesWakeOnLAN> createState() => _State();
}

class _State extends State<SettingsModulesWakeOnLAN> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    ProfileHiveObject _profile = Database.currentProfileObject;

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        body: _body,
        appBar: _appBar,
    );

    Widget get _appBar => LSAppBar(title: 'Wake on LAN');

    Widget get _body => ValueListenableBuilder(
        valueListenable: Database.profilesBox.listenable(),
        builder: (context, box, widget) {
            return LSListView(
                children: <Widget>[
                    ..._configuration,
                ],
            );
        },
    );

    List<Widget> get _configuration => [
        LSHeader(
            text: 'Configuration',
            subtitle: 'Mandatory configuration for Wake on LAN functionality',
        ),
        LSCardTile(
            title: LSTitle(text: 'Enable Wake on LAN'),
            subtitle: null,
            trailing: Switch(
                value: _profile.wakeOnLANEnabled ?? false,
                onChanged: (value) {
                    _profile.wakeOnLANEnabled = value;
                    _profile.save();
                },
            ),
        ),
        LSCardTile(
            title: LSTitle(text: 'Broadcast Address'),
            subtitle: LSSubtitle(
                text: _profile.wakeOnLANBroadcastAddress == null || _profile.wakeOnLANBroadcastAddress == ''
                    ? 'Not Set'
                    : _profile.wakeOnLANBroadcastAddress
            ),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: _changeBroadcastAddress,
        ),
        LSCardTile(
            title: LSTitle(text: 'Device MAC Address'),
            subtitle: LSSubtitle(
                text: _profile.wakeOnLANMACAddress == null || _profile.wakeOnLANMACAddress == ''
                    ? 'Not Set'
                    : _profile.wakeOnLANMACAddress
            ),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: _changeMACAddress,
        ),
    ];

    Future<void> _changeBroadcastAddress() async {
        List<dynamic> _values = await SettingsDialogs.editBroadcastAddress(context, _profile.wakeOnLANBroadcastAddress ?? '');
        if(_values[0]) {
            _profile.wakeOnLANBroadcastAddress = _values[1];
            _profile.save();
        }
    }

    Future<void> _changeMACAddress() async {
        List<dynamic> _values = await SettingsDialogs.editMACAddress(context, _profile.wakeOnLANMACAddress ?? '');
        if(_values[0]) {
            _profile.wakeOnLANMACAddress = _values[1];
            _profile.save();
        }
    }
}
