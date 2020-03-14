import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class SettingsClientsNZBGet extends StatefulWidget {
    @override
    State<SettingsClientsNZBGet> createState() => _State();
}

class _State extends State<SettingsClientsNZBGet> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    ProfileHiveObject _profile = Database.currentProfileObject;

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        body: _body,
    );

    Widget get _body => ValueListenableBuilder(
        valueListenable: Database.profilesBox.listenable(),
        builder: (context, box, widget) {
            return LSListView(
                children: <Widget>[
                    LSCardTile(
                        title: LSTitle(text: 'Enable NZBGet'),
                        subtitle: null,
                        trailing: Switch(
                            value: _profile.nzbgetEnabled ?? false,
                            onChanged: (value) {
                                _profile.nzbgetEnabled = value;
                                _profile.save();
                            },
                        ),
                    ),
                    LSDivider(),
                    LSCardTile(
                        title: LSTitle(text: 'Host'),
                        subtitle: LSSubtitle(
                            text: _profile.nzbgetHost == null || _profile.nzbgetHost == ''
                                ? 'Not Set'
                                : _profile.nzbgetHost
                        ),
                        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                        onTap: _changeHost,
                    ),
                    LSCardTile(
                        title: LSTitle(text: 'Username'),
                        subtitle: LSSubtitle(
                            text: _profile.nzbgetUser == null || _profile.nzbgetUser == ''
                                ? 'Not Set'
                                : _profile.nzbgetUser
                        ),
                        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                        onTap: _changeUser,
                    ),
                    LSCardTile(
                        title: LSTitle(text: 'Password'),
                        subtitle: LSSubtitle(
                            text: _profile.nzbgetPass == null || _profile.nzbgetPass == ''
                                ? 'Not Set'
                                : '••••••••••••'
                        ),
                        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                        onTap: _changePass,
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
        List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'NZBGet Host', prefill: _profile.nzbgetHost ?? '', showHostHint: true);
        if(_values[0]) {
            _profile.nzbgetHost = _values[1];
            _profile.save();
        }
    }

    Future<void> _changeUser() async {
        List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'NZBGet Username', prefill: _profile.nzbgetUser ?? '');
        if(_values[0]) {
            _profile.nzbgetUser = _values[1];
            _profile.save();
        }
    }

    Future<void> _changePass() async {
        List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'NZBGet Password', prefill: _profile.nzbgetPass ?? '');
        if(_values[0]) {
            _profile.nzbgetPass = _values[1];
            _profile.save();
        }
    }

    Future<void> _testConnection() async => await NZBGetAPI.from(_profile).testConnection()
        ? LSSnackBar(context: context, title: 'Connected Successfully', message: 'NZBGet is ready to use with LunaSea', type: SNACKBAR_TYPE.success)
        : LSSnackBar(context: context, title: 'Connection Test Failed', message: 'Please check the logs for more details', type: SNACKBAR_TYPE.failure);
}
