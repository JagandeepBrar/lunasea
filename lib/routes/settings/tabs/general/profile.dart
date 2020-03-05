import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

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
                Notifications.showSnackBar(_scaffoldKey, 'Unable to add profile: Name already exists');
            } else {
                Database.profilesBox.put(_values[1], ProfileHiveObject.empty());
                Database.lunaSeaBox.put('profile', _values[1]);
                Notifications.showSnackBar(_scaffoldKey, 'Profile "${_values[1]}" has been added');
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
                    Notifications.showSnackBar(_scaffoldKey, 'Unable to rename profile: Name already exists');
                } else {
                    ProfileHiveObject obj = Database.profilesBox.get(old);
                    Database.profilesBox.put(_values[1], ProfileHiveObject.from(obj));
                    if(Database.lunaSeaBox.get('profile') == old) Database.lunaSeaBox.put('profile', _values[1]);
                    obj.delete();
                    Notifications.showSnackBar(_scaffoldKey, '"$old" has been renamed to "${_values[1]}"');
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
                Notifications.showSnackBar(_scaffoldKey, 'Cannot delete enabled profile');
            } else {
                Database.profilesBox.delete(_values[1]);
                Notifications.showSnackBar(_scaffoldKey, 'Profile "${_values[1]}" has been deleted');
            }
        }
    }
}
