import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsGeneralDeleteProfileTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Delete'),
        subtitle: LSSubtitle(text: 'Delete an Existing Profile'),
        trailing: LSIconButton(icon: Icons.delete),
        onTap: () => _deleteProfile(context),
    );

    Future<void> _deleteProfile(BuildContext context) async {
        List<dynamic> _values = await SettingsDialogs.deleteProfile(
            context,
            Database.profilesBox.keys.map((x) => x as String).toList()..sort((a,b) => a.toLowerCase().compareTo(b.toLowerCase())),
        );
        if(_values[0]) {
            if(_values[1] == LunaSeaDatabaseValue.ENABLED_PROFILE.data) {
                LSSnackBar(context: context, title: 'Unable to Delete Profile', message: 'Cannot delete the enabled profile', type: SNACKBAR_TYPE.failure);
            } else {
                Database.profilesBox.delete(_values[1]);
                LSSnackBar(context: context, title: 'Deleted Profile', message: '"${_values[1]}" has been deleted', type: SNACKBAR_TYPE.success);
            }
        }
    }
}
