import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsSystemEnableSentry extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [LunaSeaDatabaseValue.ENABLED_SENTRY.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Sentry Logging'),
            subtitle: LSSubtitle(text: 'Send crashes and errors to Sentry'),
            trailing: Switch(
                value: LunaSeaDatabaseValue.ENABLED_SENTRY.data,
                onChanged: (value) async {
                    List _values = value
                        ? [true]
                        : await SettingsDialogs.disableSentryWarning(context);
                    if(_values[0]) LunaSeaDatabaseValue.ENABLED_SENTRY.put(value);
                }
            ),
        ),
    );
}
