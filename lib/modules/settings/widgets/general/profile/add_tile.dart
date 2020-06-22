import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsGeneralAddProfileTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Add'),
        subtitle: LSSubtitle(text: 'Add a New Profile'),
        trailing: LSIconButton(icon: Icons.add),
        onTap: () => _addProfile(context),
    );

    Future<void> _addProfile(BuildContext context) async {
        List<dynamic> _values = await SettingsDialogs.addProfile(context);
        if(_values[0]) {
            List profiles = Database.profilesBox.keys.map((x) => x.toString().toLowerCase()).toList();
            if(profiles.contains(_values[1].toString().toLowerCase())) {
                LSSnackBar(context: context, title: 'Unable to Add Profile', message: 'A profile with the name "${_values[1]}" already exists', type: SNACKBAR_TYPE.failure);
            } else if(_values[1] == '') {
                LSSnackBar(context: context, title: 'Unable to Add Profile', message: 'The new profile name cannot be empty', type: SNACKBAR_TYPE.failure);
            } else {
                Database.profilesBox.put(_values[1], ProfileHiveObject.empty());
                LunaSeaDatabaseValue.ENABLED_PROFILE.put(_values[1]);
                LSSnackBar(context: context, title: 'Profile Added', message: '"${_values[1]}" has been added', type: SNACKBAR_TYPE.success);
            }
        }
    }
}
