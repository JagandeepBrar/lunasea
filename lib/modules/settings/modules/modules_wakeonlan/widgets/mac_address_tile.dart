import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesWakeOnLANMACAddressTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Device MAC Address'),
        subtitle: LSSubtitle(
            text: Database.currentProfileObject.wakeOnLANMACAddress == null || Database.currentProfileObject.wakeOnLANMACAddress == ''
                ? 'Not Set'
                : Database.currentProfileObject.wakeOnLANMACAddress,
        ),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => _changeAddress(context),
    );

    Future<void> _changeAddress(BuildContext context) async {
        List<dynamic> _values = await SettingsDialogs.editMACAddress(context, Database.currentProfileObject.wakeOnLANMACAddress ?? '');
        if(_values[0]) {
            Database.currentProfileObject.wakeOnLANMACAddress = _values[1];
            Database.currentProfileObject.save();
        }
    }
}