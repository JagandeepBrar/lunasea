import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class NZBGet extends StatefulWidget {
    @override
    State<NZBGet> createState() {
        return _State();
    }
}

class _State extends State<NZBGet> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            body: _buildBody(),
        );
    }

    Widget _buildBody() {
        return ValueListenableBuilder(
            valueListenable: Database.getProfilesBox().listenable(),
            builder: (context, box, widget) {
                ProfileHiveObject profile = box.get(Database.getLunaSeaBox().get('profile'));
                return LSListView(
                    children: <Widget>[
                        LSCard(
                            title: LSTitle(text: 'Enable NZBGet'),
                            subtitle: null,
                            trailing: Switch(
                                value: profile.nzbgetEnabled,
                                onChanged: (value) {
                                    profile.nzbgetEnabled = value;
                                    profile.save();
                                },
                            ),
                        ),
                        LSDivider(),
                        LSCard(
                            title: LSTitle(text: 'Host'),
                            subtitle: LSSubtitle(
                                text: profile.nzbgetHost == ''
                                    ? 'Not Set'
                                    : profile.nzbgetHost
                            ),
                            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                            onTap: () => _changeHost(profile),
                        ),
                        LSCard(
                            title: LSTitle(text: 'Username'),
                            subtitle: LSSubtitle(
                                text: profile.nzbgetUser == ''
                                    ? 'Not Set'
                                    : profile.nzbgetUser
                            ),
                            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                            onTap: () => _changeUser(profile),
                        ),
                        LSCard(
                            title: LSTitle(text: 'Password'),
                            subtitle: LSSubtitle(
                                text: profile.nzbgetPass == ''
                                    ? 'Not Set'
                                    : '••••••••••••'
                            ),
                            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                            onTap: () => _changePass(profile),
                        ),
                        LSButton(
                            text: 'Test Connection',
                            onTap: () => _testConnection(profile),
                        ),
                    ],
                );
            }
        );
    }

    Future<void> _changeHost(ProfileHiveObject profile) async {
        List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'NZBGet Host', prefill: profile.nzbgetHost, showHostHint: true);
        if(_values[0]) {
            profile.nzbgetHost = _values[1];
            profile.save();
        }
    }

    Future<void> _changeUser(ProfileHiveObject profile) async {
        List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'NZBGet Username', prefill: profile.nzbgetUser);
        if(_values[0]) {
            profile.nzbgetUser = _values[1];
            profile.save();
        }
    }

    Future<void> _changePass(ProfileHiveObject profile) async {
        List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'NZBGet Password', prefill: profile.nzbgetPass);
        if(_values[0]) {
            profile.nzbgetPass = _values[1];
            profile.save();
        }
    }

    Future<void> _testConnection(ProfileHiveObject profile) async {
        if(await NZBGetAPI.testConnection(profile.getNZBGet())) {
            Notifications.showSnackBar(_scaffoldKey, 'Connected successfully!');
        } else {
            Notifications.showSnackBar(_scaffoldKey, 'Connection test failed');
        }
    }
}
