import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesNZBGetStrictTLSTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Strict SSL/TLS Validation'),
        subtitle: LSSubtitle(text: 'For Invalid Certificates'),
        trailing: Switch(
            value: Database.currentProfileObject.nzbgetStrictTLS ?? true,
            onChanged: (value) async => _onChanged(context, value),
        ),
    );

    Future<void> _onChanged(BuildContext context, bool value) async {
        if(value) {
            Database.currentProfileObject.nzbgetStrictTLS = value;
            Database.currentProfileObject.save(context: context);
        } else {
            List _values = await SettingsDialogs.toggleStrictTLS(context);
            if(_values[0]) {
                Database.currentProfileObject.nzbgetStrictTLS = value;
                Database.currentProfileObject.save(context: context);
            }
        }
    }
}