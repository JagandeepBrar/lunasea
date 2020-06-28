import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/nzbget.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesNZBGet extends StatefulWidget {
    static const ROUTE_NAME = '/settings/modules/nzbget';
    
    @override
    State<SettingsModulesNZBGet> createState() => _State();
}

class _State extends State<SettingsModulesNZBGet> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    ProfileHiveObject _profile = Database.currentProfileObject;

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        body: _body,
        appBar: _appBar,
    );

    Widget get _appBar => LSAppBar(title: 'NZBGet');

    List<Widget> get _configuration => [
        LSHeader(
            text: 'Configuration',
            subtitle: 'Mandatory configuration for NZBGet functionality',
        ),
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
        LSDivider(),
        LSButton(
            text: 'Test Connection',
            onTap: _testConnection,
        ),
    ];

    List<Widget> get _customization => [
        LSHeader(
            text: 'Customization',
            subtitle: 'Customize NZBGet to fit your needs',
        ),
        ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [NZBGetDatabaseValue.NAVIGATION_INDEX.key]),
            builder: (context, box, _) => LSCardTile(
                title: LSTitle(text: 'Default Page'),
                subtitle: LSSubtitle(
                    text: NZBGetNavigationBar.titles[NZBGetDatabaseValue.NAVIGATION_INDEX.data],
                ),
                trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                onTap: () async => _defaultPage(),
            ),
        ),
    ];

    List<Widget> get _advanced => [
        LSHeader(
            text: 'Advanced',
            subtitle: 'Advanced options for users with non-standard networking configurations. Be careful!',
        ),
        LSCardTile(
            title: LSTitle(text: 'Custom Headers'),
            subtitle: LSSubtitle(text: 'Add Custom Headers to Requests'),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async => Navigator.of(context).pushNamed(SettingsModulesNZBGetHeaders.ROUTE_NAME),
        ),
        LSCardTile(
            title: LSTitle(text: 'Strict SSL/TLS Validation'),
            subtitle: LSSubtitle(text: 'For Invalid Certificates'),
            trailing: Switch(
                value: _profile.nzbgetStrictTLS ?? true,
                onChanged: (value) async {
                    if(value) {
                        _profile.nzbgetStrictTLS = value;
                        _profile.save();
                    } else {
                        List _values = await SettingsDialogs.toggleStrictTLS(context);
                        if(_values[0]) {
                            _profile.nzbgetStrictTLS = value;
                            _profile.save();
                        }
                    }
                },
            ),
        ),
        LSCardTile(
            title: LSTitle(text: 'Use Basic Authentication'),
            subtitle: LSSubtitle(text: 'Different Authentication Method'),
            trailing: Switch(
                value: _profile.nzbgetBasicAuth ?? false,
                onChanged: (value) async {
                    if(!value) {
                        _profile.nzbgetBasicAuth = value;
                        _profile.save();
                    } else {
                        List _values = await SettingsDialogs.nzbgetBasicAuthentication(context);
                        if(_values[0]) {
                            _profile.nzbgetBasicAuth = value;
                            _profile.save();
                        }
                    }
                },
            ),
        ),
    ];

    Widget get _body => ValueListenableBuilder(
        valueListenable: Database.profilesBox.listenable(),
        builder: (context, box, widget) {
            return LSListView(
                children: <Widget>[
                    ..._configuration,
                    ..._customization,
                    ..._advanced,
                ],
            );
        },
    );

    Future<void> _changeHost() async {
        List<dynamic> _values = await SettingsDialogs.editHost(context, 'NZBGet Host', prefill: _profile.nzbgetHost ?? '');
        if(_values[0]) {
            _profile.nzbgetHost = _values[1];
            _profile.save();
        }
    }

    Future<void> _changeUser() async {
        List<dynamic> _values = await GlobalDialogs.editText(context, 'NZBGet Username', prefill: _profile.nzbgetUser ?? '');
        if(_values[0]) {
            _profile.nzbgetUser = _values[1];
            _profile.save();
        }
    }

    Future<void> _changePass() async {
        List<dynamic> _values = await GlobalDialogs.editText(context, 'NZBGet Password', prefill: _profile.nzbgetPass ?? '');
        if(_values[0]) {
            _profile.nzbgetPass = _values[1];
            _profile.save();
        }
    }

    Future<void> _defaultPage() async {
        List<dynamic> _values = await NZBGetDialogs.defaultPage(context);
        if(_values[0]) NZBGetDatabaseValue.NAVIGATION_INDEX.put(_values[1]);
    }

    Future<void> _testConnection() async => await NZBGetAPI.from(_profile).testConnection()
        ? LSSnackBar(context: context, title: 'Connected Successfully', message: 'NZBGet is ready to use with LunaSea', type: SNACKBAR_TYPE.success)
        : LSSnackBar(context: context, title: 'Connection Test Failed', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure);
}
