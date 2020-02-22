import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class SettingsAutomationSonarr extends StatefulWidget {
    @override
    State<SettingsAutomationSonarr> createState() => _State();
}

class _State extends State<SettingsAutomationSonarr> {
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
                        title: LSTitle(text: 'Enable Sonarr'),
                        subtitle: null,
                        trailing: Switch(
                            value: _profile.sonarrEnabled,
                            onChanged: (value) {
                                _profile.sonarrEnabled = value;
                                _profile.save();
                            },
                        ),
                    ),
                    LSDivider(),
                    LSCard(
                        title: LSTitle(text: 'Host'),
                        subtitle: LSSubtitle(
                            text: _profile.sonarrHost == ''
                                ? 'Not Set'
                                : _profile.sonarrHost
                        ),
                        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                        onTap: _changeHost,
                    ),
                    LSCard(
                        title: LSTitle(text: 'API Key'),
                        subtitle: LSSubtitle(
                            text: _profile.sonarrKey == ''
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
        List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'Sonarr Host', prefill: _profile.sonarrHost, showHostHint: true);
        if(_values[0]) {
            _profile.sonarrHost = _values[1];
            _profile.save();
        }
    }

    Future<void> _changeKey() async {
        List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'Sonarr API Key', prefill: _profile.sonarrKey);
        if(_values[0]) {
            _profile.sonarrKey = _values[1];
            _profile.save();
        }
    }

    Future<void> _testConnection() async => await SonarrAPI.from(_profile).testConnection()
        ? Notifications.showSnackBar(_scaffoldKey, 'Connected successfully!')
        : Notifications.showSnackBar(_scaffoldKey, 'Connection test failed');
}
