import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class SABnzbd extends StatefulWidget {
    @override
    State<SABnzbd> createState() {
        return _State();
    }
}

class _State extends State<SABnzbd> {
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
                            title: LSTitle(text: 'Enable SABnzbd'),
                            subtitle: null,
                            trailing: Switch(
                                value: profile.sabnzbdEnabled,
                                onChanged: (value) {
                                    profile.sabnzbdEnabled = value;
                                    profile.save();
                                },
                            ),
                        ),
                        LSDivider(),
                        LSCard(
                            title: LSTitle(text: 'Host'),
                            subtitle: LSSubtitle(
                                text: profile.sabnzbdHost == ''
                                    ? 'Not Set'
                                    : profile.sabnzbdHost
                            ),
                            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                            onTap: () => _changeHost(profile),
                        ),
                        LSCard(
                            title: LSTitle(text: 'API Key'),
                            subtitle: LSSubtitle(
                                text: profile.sabnzbdKey == ''
                                    ? 'Not Set'
                                    : '••••••••••••'
                            ),
                            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                            onTap: () => _changeKey(profile),
                        ),
                        LSButton(
                            text: 'Test Connection',
                            onTap: () => _testConnection(profile),
                        ),
                    ],
                );
            },
        );
    }

    Future<void> _changeHost(ProfileHiveObject profile) async {
        List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'SABnzbd Host', prefill: profile.sabnzbdHost, showHostHint: true);
        if(_values[0]) {
            profile.sabnzbdHost = _values[1];
            profile.save();
        }
    }

    Future<void> _changeKey(ProfileHiveObject profile) async {
        List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'SABnzbd API Key', prefill: profile.sabnzbdKey);
        if(_values[0]) {
            profile.sabnzbdKey = _values[1];
            profile.save();
        }
    }

    Future<void> _testConnection(ProfileHiveObject profile) async {
        SABnzbdAPI api = SABnzbdAPI.from(profile);
        await api.testConnection()
            ? Notifications.showSnackBar(_scaffoldKey, 'Connected successfully!')
            : Notifications.showSnackBar(_scaffoldKey, 'Connection test failed');
    }
}
