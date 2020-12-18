import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsProfileRenameTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Rename'),
        subtitle: LSSubtitle(text: 'Rename an Existing Profile'),
        trailing: LSIconButton(icon: Icons.text_format),
        onTap: () => _renameProfile(context),
    );

    Future<void> _renameProfile(BuildContext context) async {
        List<dynamic> _values = await SettingsDialogs.renameProfile(
            context,
            Database.profilesBox.keys.map((x) => x as String).toList()..sort((a,b) => a.toLowerCase().compareTo(b.toLowerCase())),
        );
        if(_values[0]) {
            String old = _values[1];
            _values = await SettingsDialogs.renameProfileSelected(context);
            if(_values[0]) {
                if(Database.profilesBox.keys.contains(_values[1])) {
                    showLunaErrorSnackBar(
                        context: context,
                        title: 'Unable to Rename Profile',
                        message: 'A profile with the name "${_values[1]}" already exists',
                    );
                } else if(_values[1] == '') {
                    showLunaErrorSnackBar(
                        context: context,
                        title: 'Unable to Rename Profile',
                        message: 'The new name cannot be empty',
                    );
                } else {
                    ProfileHiveObject obj = Database.profilesBox.get(old);
                    Database.profilesBox.put(_values[1], ProfileHiveObject.fromProfileHiveObject(obj));
                    if(LunaDatabaseValue.ENABLED_PROFILE.data == old) LunaProfile().safelyChangeProfiles(context, _values[1]);
                    obj.delete();
                    showLunaSuccessSnackBar(
                        context: context,
                        title: 'Renamed Profile',
                        message: '"$old" has been renamed to "${_values[1]}"'
                    );
                }
            }
        }
    }
}
