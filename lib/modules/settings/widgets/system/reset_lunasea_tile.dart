import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsSystemClearConfigurationTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Reset LunaSea'),
        subtitle: LSSubtitle(text: 'Clear Your Configuration'),
        trailing: LSIconButton(icon: Icons.delete_sweep),
        onTap: () => _clear(context),
    );

    Future<void> _clear(BuildContext context) async {
        List values = await SettingsDialogs.clearLunaSeaConfiguration(context);
        if(values[0]) {
            Database.setDefaults();
            LSSnackBar(
                context: context,
                title: 'LunaSea Reset Successful',
                message: 'Your configuration has been cleared',
                type: SNACKBAR_TYPE.success,
            );
        }
    }
}
