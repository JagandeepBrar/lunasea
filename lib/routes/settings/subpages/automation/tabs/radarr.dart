import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class Radarr extends StatefulWidget {
    @override
    State<Radarr> createState() {
        return _State();
    }
}

class _State extends State<Radarr> {
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
                            title: LSTitle(text: 'Enable Radarr'),
                            subtitle: null,
                            trailing: Switch(
                                value: profile.radarrEnabled,
                                onChanged: (value) {
                                    profile.radarrEnabled = value;
                                    profile.save();
                                },
                            ),
                        ),
                        LSDivider(),
                        LSCard(
                            title: LSTitle(text: 'Host'),
                            subtitle: LSSubtitle(
                                text: profile.radarrHost == ''
                                    ? 'Not Set'
                                    : profile.radarrHost
                            ),
                            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                            onTap: () => _changeHost(profile),
                        ),
                        LSCard(
                            title: LSTitle(text: 'API Key'),
                            subtitle: LSSubtitle(
                                text: profile.radarrKey == ''
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
        List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'Radarr Host', prefill: profile.radarrHost, showHostHint: true);
        if(_values[0]) {
            profile.radarrHost = _values[1];
            profile.save();
        }
    }

    Future<void> _changeKey(ProfileHiveObject profile) async {
        List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'Radarr API Key', prefill: profile.radarrKey);
        if(_values[0]) {
            profile.radarrKey = _values[1];
            profile.save();
        }
    }

    Future<void> _testConnection(ProfileHiveObject profile) async {
        RadarrAPI api = RadarrAPI.from(profile);
        await api.testConnection()
            ? Notifications.showSnackBar(_scaffoldKey, 'Connected successfully!')
            : Notifications.showSnackBar(_scaffoldKey, 'Connection test failed');
    }
}
