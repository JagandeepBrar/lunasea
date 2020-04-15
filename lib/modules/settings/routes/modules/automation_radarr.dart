import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class SettingsModulesRadarr extends StatefulWidget {
    static const ROUTE_NAME = '/settings/modules/radarr';
    
    @override
    State<SettingsModulesRadarr> createState() => _State();
}

class _State extends State<SettingsModulesRadarr> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    ProfileHiveObject _profile = Database.currentProfileObject;

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        body: _body,
        appBar: _appBar,
    );

    Widget get _appBar => LSAppBar(title: 'Radarr');

    Widget get _body => ValueListenableBuilder(
        valueListenable: Database.profilesBox.listenable(),
        builder: (context, box, widget) {
            return LSListView(
                children: <Widget>[
                    LSHeader(text: 'Configuration'),
                    LSCardTile(
                        title: LSTitle(text: 'Enable Radarr'),
                        subtitle: null,
                        trailing: Switch(
                            value: _profile.radarrEnabled ?? false,
                            onChanged: (value) {
                                _profile.radarrEnabled = value;
                                _profile.save();
                            },
                        ),
                    ),
                    LSCardTile(
                        title: LSTitle(text: 'Host'),
                        subtitle: LSSubtitle(
                            text: _profile.radarrHost == null || _profile.radarrHost == ''
                                ? 'Not Set'
                                : _profile.radarrHost
                        ),
                        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                        onTap: _changeHost,
                    ),
                    LSCardTile(
                        title: LSTitle(text: 'API Key'),
                        subtitle: LSSubtitle(
                            text: _profile.radarrKey == null || _profile.radarrKey == ''
                                ? 'Not Set'
                                : '••••••••••••'
                        ),
                        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                        onTap: _changeKey,
                    ),
                    LSDivider(),
                    LSButton(
                        text: 'Test Connection',
                        onTap: _testConnection,
                    ),
                    LSHeader(text: 'Advanced'),
                    LSCardTile(
                        title: LSTitle(text: 'Strict SSL/TLS Validation'),
                        subtitle: LSSubtitle(
                            text: _profile.radarrStrictTLS ?? true
                                ? 'Strict SSL/TLS validation is enabled'
                                : 'Strict SSL/TLS validation is disabled',
                        ),
                        trailing: Switch(
                            value: _profile.radarrStrictTLS ?? true,
                            onChanged: (value) async {
                                if(value) {
                                    _profile.radarrStrictTLS = value;
                                    _profile.save();
                                } else {
                                    List _values = await LSDialogSettings.toggleStrictTLS(context);
                                    if(_values[0]) {
                                        _profile.radarrStrictTLS = value;
                                        _profile.save();
                                    }
                                }
                            },
                        ),
                    ),
                ],
            );
        },
    );

    Future<void> _changeHost() async {
        List<dynamic> _values = await LSDialogSystem.editText(context, 'Radarr Host', prefill: _profile.radarrHost ?? '', showHostHint: true);
        if(_values[0]) {
            _profile.radarrHost = _values[1];
            _profile.save();
        }
    }

    Future<void> _changeKey() async {
        List<dynamic> _values = await LSDialogSystem.editText(context, 'Radarr API Key', prefill: _profile.radarrKey ?? '');
        if(_values[0]) {
            _profile.radarrKey = _values[1];
            _profile.save();
        }
    }

    Future<void> _testConnection() async => await RadarrAPI.from(_profile).testConnection()
        ? LSSnackBar(context: context, title: 'Connected Successfully', message: 'Radarr is ready to use with LunaSea', type: SNACKBAR_TYPE.success)
        : LSSnackBar(context: context, title: 'Connection Test Failed', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure);
}
