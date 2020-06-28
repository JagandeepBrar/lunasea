import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesSonarr extends StatefulWidget {
    static const ROUTE_NAME = '/settings/modules/sonarr';
    
    @override
    State<SettingsModulesSonarr> createState() => _State();
}

class _State extends State<SettingsModulesSonarr> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    ProfileHiveObject _profile = Database.currentProfileObject;

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        body: _body,
        appBar: _appBar,
    );

    Widget get _appBar => LSAppBar(title: 'Sonarr');

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

    List<Widget> get _configuration => [
        LSHeader(
            text: 'Configuration',
            subtitle: 'Mandatory configuration for Sonarr functionality',
        ),
        LSCardTile(
            title: LSTitle(text: 'Enable Sonarr'),
            subtitle: null,
            trailing: Switch(
                value: _profile.sonarrEnabled ?? false,
                onChanged: (value) {
                    _profile.sonarrEnabled = value;
                    _profile.save();
                },
            ),
        ),
        LSCardTile(
            title: LSTitle(text: 'Host'),
            subtitle: LSSubtitle(
                text: _profile.sonarrHost == null || _profile.sonarrHost == ''
                    ? 'Not Set'
                    : _profile.sonarrHost
            ),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: _changeHost,
        ),
        LSCardTile(
            title: LSTitle(text: 'API Key'),
            subtitle: LSSubtitle(
                text: _profile.sonarrKey == null || _profile.sonarrKey == ''
                    ? 'Not Set'
                    : '••••••••••••'
            ),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: _changeKey,
        ),
        // LSCardTile(
        //     title: LSTitle(text: 'Sonarr v3'),
        //     subtitle: LSSubtitle(text: 'Enable Sonarr v3 Features'),
        //     trailing: Switch(
        //         value: _profile.sonarrVersion3 ?? false,
        //         onChanged: (value) async {
        //             _profile.sonarrVersion3 = value;
        //             _profile.save();
        //         },
        //     ),
        // ),
        LSDivider(),
        LSButton(
            text: 'Test Connection',
            onTap: _testConnection,
        ),
    ];

    List<Widget> get _customization => [
        LSHeader(
            text: 'Customization',
            subtitle: 'Customize Sonarr to fit your needs',
        ),
        ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [SonarrDatabaseValue.NAVIGATION_INDEX.key]),
            builder: (context, box, _) => LSCardTile(
                title: LSTitle(text: 'Default Page'),
                subtitle: LSSubtitle(
                    text: SonarrNavigationBar.titles[SonarrDatabaseValue.NAVIGATION_INDEX.data],
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
            onTap: () async => Navigator.of(context).pushNamed(SettingsModulesSonarrHeaders.ROUTE_NAME),
        ),
        LSCardTile(
            title: LSTitle(text: 'Strict SSL/TLS Validation'),
            subtitle: LSSubtitle(text: 'For Invalid Certificates'),
            trailing: Switch(
                value: _profile.sonarrStrictTLS ?? true,
                onChanged: (value) async {
                    if(value) {
                        _profile.sonarrStrictTLS = value;
                        _profile.save();
                    } else {
                        List _values = await SettingsDialogs.toggleStrictTLS(context);
                        if(_values[0]) {
                            _profile.sonarrStrictTLS = value;
                            _profile.save();
                        }
                    }
                },
            ),
        ),
    ];

    Future<void> _changeHost() async {
        List<dynamic> _values = await SettingsDialogs.editHost(context, 'Sonarr Host', prefill: _profile.sonarrHost ?? '');
        if(_values[0]) {
            _profile.sonarrHost = _values[1];
            _profile.save();
        }
    }

    Future<void> _changeKey() async {
        List<dynamic> _values = await GlobalDialogs.editText(context, 'Sonarr API Key', prefill: _profile.sonarrKey ?? '');
        if(_values[0]) {
            _profile.sonarrKey = _values[1];
            _profile.save();
        }
    }

    Future<void> _defaultPage() async {
        List<dynamic> _values = await SonarrDialogs.defaultPage(context);
        if(_values[0]) SonarrDatabaseValue.NAVIGATION_INDEX.put(_values[1]);
    }

    Future<void> _testConnection() async => await SonarrAPI.from(_profile).testConnection()
        ? LSSnackBar(context: context, title: 'Connected Successfully', message: 'Sonarr is ready to use with LunaSea', type: SNACKBAR_TYPE.success)
        : LSSnackBar(context: context, title: 'Connection Test Failed', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure);
}
