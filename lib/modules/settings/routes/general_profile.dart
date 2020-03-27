import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsGeneralProfile extends StatefulWidget {
    @override
    State<SettingsGeneralProfile> createState() => _State();
}

class _State extends State<SettingsGeneralProfile> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        body: _body,
    );

    Widget get _body => LSListView(
        children: <Widget>[
            LSCardTile(
                title: LSTitle(text: 'Enabled Profile'),
                subtitle: ValueListenableBuilder(
                    valueListenable: Database.lunaSeaBox.listenable(keys: ['profile']),
                    builder: (context, box, widget) => Elements.getSubtitle(box.get('profile')),
                ),
                trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                onTap: _changeProfile,
            ),
            LSDivider(),
            LSCardTile(
                title: LSTitle(text: 'Add'),
                subtitle: LSSubtitle(text: 'Add a new profile'),
                trailing: LSIconButton(icon: Icons.add),
                onTap: _addProfile,
            ),
            LSCardTile(
                title: LSTitle(text: 'Rename'),
                subtitle: LSSubtitle(text: 'Rename an existing profile'),
                trailing: LSIconButton(
                    icon: Icons.text_format,
                ),
                onTap: _renameProfile,
            ),
            LSCardTile(
                title: LSTitle(text: 'Delete'),
                subtitle: LSSubtitle(text: 'Delete an existing profile'),
                trailing: LSIconButton(icon: Icons.delete),
                onTap: _deleteProfile,
            ),
        ],
    );

    Future<void> _changeProfile() async {
        List<dynamic> values = await SystemDialogs.showChangeProfilePrompt(
            context,
            Database.profilesBox.keys.map((x) => x as String).toList()..sort((a,b) => a.toLowerCase().compareTo(b.toLowerCase())),
        );
        if(values[0]) {
            if(values[1] != Database.lunaSeaBox.get('profile')) {
                Database.lunaSeaBox.put('profile', values[1]);
            }
        }
    }

    Future<void> _addProfile() async {
        List<dynamic> _values = await SystemDialogs.showAddProfilePrompt(context);
        if(_values[0]) {
            List profiles = Database.profilesBox.keys.map((x) => x.toString().toLowerCase()).toList();
            if(profiles.contains(_values[1].toString().toLowerCase())) {
                LSSnackBar(context: context, title: 'Unable to Add Profile', message: 'A profile with the name "${_values[1]}" already exists', type: SNACKBAR_TYPE.failure);
            } else if(_values[1] == '') {
                LSSnackBar(context: context, title: 'Unable to Add Profile', message: 'The new profile name cannot be empty', type: SNACKBAR_TYPE.failure);
            } else {
                Database.profilesBox.put(_values[1], ProfileHiveObject.empty());
                Database.lunaSeaBox.put('profile', _values[1]);
                LSSnackBar(context: context, title: 'Profile Added', message: '"${_values[1]}" has been added', type: SNACKBAR_TYPE.success);
            }
        }
    }

    Future<void> _renameProfile() async {
        List<dynamic> _values = await SystemDialogs.showRenameProfilePrompt(
            context,
            Database.profilesBox.keys.map((x) => x as String).toList()..sort((a,b) => a.toLowerCase().compareTo(b.toLowerCase())),
        );
        if(_values[0]) {
            String old = _values[1];
            _values = await SystemDialogs.showRenameProfileFieldPrompt(context);
            if(_values[0]) {
                if(Database.profilesBox.keys.contains(_values[1])) {
                    LSSnackBar(context: context, title: 'Unable to Rename Profile', message: 'A profile with the name "${_values[1]}" already exists', type: SNACKBAR_TYPE.failure);
                } else if(_values[1] == '') {
                    LSSnackBar(context: context, title: 'Unable to Rename Profile', message: 'The new name cannot be empty', type: SNACKBAR_TYPE.failure);
                } else {
                    ProfileHiveObject obj = Database.profilesBox.get(old);
                    Database.profilesBox.put(_values[1], ProfileHiveObject.from(obj));
                    if(Database.lunaSeaBox.get('profile') == old) Database.lunaSeaBox.put('profile', _values[1]);
                    obj.delete();
                    LSSnackBar(context: context, title: 'Renamed Profile', message: '"$old" has been renamed to "${_values[1]}"', type: SNACKBAR_TYPE.success);
                }
            }
        }
    }

    Future<void> _deleteProfile() async {
        List<dynamic> _values = await SystemDialogs.showDeleteProfilePrompt(
            context,
            Database.profilesBox.keys.map((x) => x as String).toList()..sort((a,b) => a.toLowerCase().compareTo(b.toLowerCase())),
        );
        if(_values[0]) {
            if(_values[1] == Database.lunaSeaBox.get('profile')) {
                LSSnackBar(context: context, title: 'Unable to Delete Profile', message: 'Cannot delete the enabled profile', type: SNACKBAR_TYPE.failure);
            } else {
                Database.profilesBox.delete(_values[1]);
                LSSnackBar(context: context, title: 'Deleted Profile', message: '"${_values[1]}" has been deleted', type: SNACKBAR_TYPE.success);
            }
        }
    }
}
