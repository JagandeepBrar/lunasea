import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class Sonarr extends StatefulWidget {
    @override
    State<Sonarr> createState() {
        return _State();
    }
}

class _State extends State<Sonarr> {
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
                            title: LSTitle(text: 'Enable Sonarr'),
                            subtitle: null,
                            trailing: Switch(
                                value: profile.sonarrEnabled,
                                onChanged: (value) {
                                    profile.sonarrEnabled = value;
                                    profile.save();
                                },
                            ),
                        ),
                        LSDivider(),
                        LSCard(
                            title: LSTitle(text: 'Host'),
                            subtitle: LSSubtitle(
                                text: profile.sonarrHost == ''
                                    ? 'Not Set'
                                    : profile.sonarrHost
                            ),
                            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                            onTap: () => _changeHost(profile),
                        ),
                        LSCard(
                            title: LSTitle(text: 'API Key'),
                            subtitle: LSSubtitle(
                                text: profile.sonarrKey == ''
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
        List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'Sonarr Host', prefill: profile.sonarrHost, showHostHint: true);
        if(_values[0]) {
            profile.sonarrHost = _values[1];
            profile.save();
        }
    }

    Future<void> _changeKey(ProfileHiveObject profile) async {
        List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'Sonarr API Key', prefill: profile.sonarrKey);
        if(_values[0]) {
            profile.sonarrKey = _values[1];
            profile.save();
        }
    }

    Future<void> _testConnection(ProfileHiveObject profile) async {
        SonarrAPI api = SonarrAPI.from(profile);
        await api.testConnection()
            ? Notifications.showSnackBar(_scaffoldKey, 'Connected successfully!')
            : Notifications.showSnackBar(_scaffoldKey, 'Connection test failed');
    }
}
