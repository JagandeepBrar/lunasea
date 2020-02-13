import 'package:flutter/material.dart';
import 'package:lunasea/system.dart';
import 'package:lunasea/widgets/ui.dart';

class Profile extends StatefulWidget {
    @override
    State<Profile> createState() {
        return _State();
    }
}

class _State extends State<Profile> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    void initState() {
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            body: _profileSettings(),
        );
    }

    Widget _profileSettings() {
        return Scrollbar(
            child: ListView(
                children: <Widget>[
                    Card(
                        child: ListTile(
                            title: Elements.getTitle('Enabled Profile'),
                            subtitle: ValueListenableBuilder(
                                valueListenable: Database.getLunaSeaBox().listenable(keys: ['profile']),
                                builder: (context, box, widget) => Elements.getSubtitle(box.get('profile')),
                            ),
                            onTap: () async {
                                List<dynamic> values = await SystemDialogs.showChangeProfilePrompt(
                                    context,
                                    Database.getProfilesBox().keys.map((x) => x as String).toList()..sort((a,b) => a.compareTo(b)),
                                );
                                if(values[0]) {
                                    if(values[1] != Database.getLunaSeaBox().get('profile')) {
                                        Database.getLunaSeaBox().put('profile', values[1]);
                                    }
                                }
                            },
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.arrow_forward_ios),
                                onPressed: null,
                            ),
                        ),
                        margin: Elements.getCardMargin(),
                        elevation: 4.0,
                    ),
                    Elements.getDivider(),
                    Card(
                        child: ListTile(
                            title: Elements.getTitle('Add'),
                            subtitle: Elements.getSubtitle('Add a new profile'),
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.add),
                                onPressed: null,
                            ),
                            onTap: () async {
                                List<dynamic> _values = await SystemDialogs.showAddProfilePrompt(context);
                                if(_values[0]) {
                                    if(Database.getProfilesBox().keys.contains(_values[1])) {
                                        Notifications.showSnackBar(_scaffoldKey, 'Unable to add profile: Name already exists');
                                    } else {
                                        Database.getProfilesBox().put(_values[1], ProfileHiveObject.empty());
                                        Database.getLunaSeaBox().put('profile', _values[1]);
                                        Notifications.showSnackBar(_scaffoldKey, 'Profile "${_values[1]}" has been added');
                                    }
                                }
                            }
                        ),
                        margin: Elements.getCardMargin(),
                        elevation: 4.0,
                    ),
                    Card(
                        child: ListTile(
                            title: Elements.getTitle('Rename'),
                            subtitle: Elements.getSubtitle('Rename a profile'),
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.text_format),
                                onPressed: null,
                            ),
                            onTap: () async {
                                List<dynamic> _values = await SystemDialogs.showRenameProfilePrompt(
                                    context,
                                    Database.getProfilesBox().keys.map((x) => x as String).toList()..sort((a,b) => a.compareTo(b)),
                                );
                                if(_values[0]) {
                                    String old = _values[1];
                                    _values = await SystemDialogs.showRenameProfileFieldPrompt(context);
                                    if(_values[0]) {
                                        if(Database.getProfilesBox().keys.contains(_values[1])) {
                                            Notifications.showSnackBar(_scaffoldKey, 'Unable to rename profile: Name already exists');
                                        } else {
                                            ProfileHiveObject obj = Database.getProfilesBox().get(old);
                                            Database.getProfilesBox().put(_values[1], ProfileHiveObject.from(obj));
                                            if(Database.getLunaSeaBox().get('profile') == old) Database.getLunaSeaBox().put('profile', _values[1]);
                                            obj.delete();
                                            Notifications.showSnackBar(_scaffoldKey, '"$old" has been renamed to "${_values[1]}"');
                                        }
                                    }
                                }
                            }
                        ),
                        margin: Elements.getCardMargin(),
                        elevation: 4.0,
                    ),
                    Card(
                        child: ListTile(
                            title: Elements.getTitle('Delete'),
                            subtitle: Elements.getSubtitle('Delete an existing profile'),
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.delete),
                                onPressed: null,
                            ),
                            onTap: () async {
                                List<dynamic> _values = await SystemDialogs.showDeleteProfilePrompt(
                                    context,
                                    Database.getProfilesBox().keys.map((x) => x as String).toList()..sort((a,b) => a.compareTo(b)),
                                );
                                if(_values[0]) {
                                    if(_values[1] == Database.getLunaSeaBox().get('profile')) {
                                        Notifications.showSnackBar(_scaffoldKey, 'Cannot delete enabled profile');
                                    } else {
                                        Database.getProfilesBox().delete(_values[1]);
                                        Notifications.showSnackBar(_scaffoldKey, 'Profile "${_values[1]}" has been deleted');
                                    }
                                }
                            },
                        ),
                        margin: Elements.getCardMargin(),
                        elevation: 4.0,
                    ),
                ],
                padding: Elements.getListViewPadding(),
            ),
        );
    }
}
