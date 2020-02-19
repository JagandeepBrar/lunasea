import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class Lidarr extends StatefulWidget {
    @override
    State<Lidarr> createState() {
        return _State();
    }
}

class _State extends State<Lidarr> {
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
                            title: LSTitle(text: 'Enable Lidarr'),
                            subtitle: null,
                            trailing: Switch(
                                value: profile.lidarrEnabled,
                                onChanged: (value) {
                                    profile.lidarrEnabled = value;
                                    profile.save();
                                },
                            ),
                        ),
                        LSDivider(),
                        LSCard(
                            title: LSTitle(text: 'Host'),
                            subtitle: LSSubtitle(
                                text: profile.lidarrHost == ''
                                    ? 'Not Set'
                                    : profile.lidarrHost
                            ),
                            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                            onTap: () => _changeHost(profile),
                        ),
                        LSCard(
                            title: LSTitle(text: 'API Key'),
                            subtitle: LSSubtitle(
                                text: profile.lidarrKey == ''
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
        List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'Lidarr Host', prefill: profile.lidarrHost, showHostHint: true);
        if(_values[0]) {
            profile.lidarrHost = _values[1];
            profile.save();
        }
    }

    Future<void> _changeKey(ProfileHiveObject profile) async {
        List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'Lidarr API Key', prefill: profile.lidarrKey);
        if(_values[0]) {
            profile.lidarrKey = _values[1];
            profile.save();
        }
    }

    Future<void> _testConnection(ProfileHiveObject profile) async {
        if(await LidarrAPI.testConnection(profile.getLidarr())) {
            Notifications.showSnackBar(_scaffoldKey, 'Connected successfully!');
        } else {
            Notifications.showSnackBar(_scaffoldKey, 'Connection test failed');
        }
    }
}
