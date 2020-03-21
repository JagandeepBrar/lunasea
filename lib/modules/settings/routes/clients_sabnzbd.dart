import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsClientsSABnzbd extends StatefulWidget {
    @override
    State<SettingsClientsSABnzbd> createState() => _State();
}

class _State extends State<SettingsClientsSABnzbd> {
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
                        title: LSTitle(text: 'Enable SABnzbd'),
                        subtitle: null,
                        trailing: Switch(
                            value: _profile.sabnzbdEnabled ?? false,
                            onChanged: (value) {
                                _profile.sabnzbdEnabled = value;
                                _profile.save();
                            },
                        ),
                    ),
                    LSDivider(),
                    LSCardTile(
                        title: LSTitle(text: 'Host'),
                        subtitle: LSSubtitle(
                            text: _profile.sabnzbdHost == null || _profile.sabnzbdHost == ''
                                ? 'Not Set'
                                : _profile.sabnzbdHost
                        ),
                        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                        onTap: _changeHost,
                    ),
                    LSCardTile(
                        title: LSTitle(text: 'API Key'),
                        subtitle: LSSubtitle(
                            text: _profile.sabnzbdKey == null || _profile.sabnzbdKey == ''
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
        List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'SABnzbd Host', prefill: _profile.sabnzbdHost ?? '', showHostHint: true);
        if(_values[0]) {
            _profile.sabnzbdHost = _values[1];
            _profile.save();
        }
    }

    Future<void> _changeKey() async {
        List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'SABnzbd API Key', prefill: _profile.sabnzbdKey ?? '');
        if(_values[0]) {
            _profile.sabnzbdKey = _values[1];
            _profile.save();
        }
    }

    Future<void> _testConnection() async => await SABnzbdAPI.from(_profile).testConnection()
        ? LSSnackBar(context: context, title: 'Connected Successfully', message: 'SABnzbd is ready to use with LunaSea', type: SNACKBAR_TYPE.success)
        : LSSnackBar(context: context, title: 'Connection Test Failed', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure);
}
