import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class SettingsAutomationLidarr extends StatefulWidget {
    @override
    State<SettingsAutomationLidarr> createState() => _State();
}

class _State extends State<SettingsAutomationLidarr> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    ProfileHiveObject _profile = Database.currentProfileObject;

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            body: _body,
        );
    }

    Widget get _body => ValueListenableBuilder(
        valueListenable: Database.getProfilesBox().listenable(),
        builder: (context, box, widget) {
            return LSListView(
                children: <Widget>[
                    LSCard(
                        title: LSTitle(text: 'Enable Lidarr'),
                        subtitle: null,
                        trailing: Switch(
                            value: _profile.lidarrEnabled,
                            onChanged: (value) {
                                _profile.lidarrEnabled = value;
                                _profile.save();
                            },
                        ),
                    ),
                    LSDivider(),
                    LSCard(
                        title: LSTitle(text: 'Host'),
                        subtitle: LSSubtitle(
                            text: _profile.lidarrHost == ''
                                ? 'Not Set'
                                : _profile.lidarrHost
                        ),
                        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                        onTap: _changeHost,
                    ),
                    LSCard(
                        title: LSTitle(text: 'API Key'),
                        subtitle: LSSubtitle(
                            text: _profile.lidarrKey == ''
                                ? 'Not Set'
                                : '••••••••••••'
                        ),
                        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                        onTap: _changeKey,
                    ),
                    LSButton(
                        text: 'Test Connection',
                        onTap: _testConnection,
                    ),
                ],
            );
        },
    );

    Future<void> _changeHost() async {
        List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'Lidarr Host', prefill: _profile.lidarrHost, showHostHint: true);
        if(_values[0]) {
            _profile.lidarrHost = _values[1];
            _profile.save();
        }
    }

    Future<void> _changeKey() async {
        List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'Lidarr API Key', prefill: _profile.lidarrKey);
        if(_values[0]) {
            _profile.lidarrKey = _values[1];
            _profile.save();
        }
    }

    Future<void> _testConnection() async => await LidarrAPI.from(_profile).testConnection()
        ? Notifications.showSnackBar(_scaffoldKey, 'Connected successfully!')
        : Notifications.showSnackBar(_scaffoldKey, 'Connection test failed');
}
