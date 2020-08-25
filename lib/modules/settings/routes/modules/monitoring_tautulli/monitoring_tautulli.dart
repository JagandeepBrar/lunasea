import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart' hide Tautulli;
import 'package:lunasea/modules/settings.dart';

class SettingsModulesTautulli extends StatefulWidget {
    static const ROUTE_NAME = '/settings/modules/tautulli';
    
    @override
    State<SettingsModulesTautulli> createState() => _State();
}

class _State extends State<SettingsModulesTautulli> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    ProfileHiveObject _profile = Database.currentProfileObject;

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        body: _body,
        appBar: _appBar,
    );

    Widget get _appBar => LSAppBar(title: 'Tautulli');

    List<Widget> get _configuration => [
        LSHeader(
            text: 'Configuration',
            subtitle: 'Mandatory configuration for Tautulli functionality',
        ),
        LSCardTile(
            title: LSTitle(text: 'Enable Tautulli'),
            subtitle: null,
            trailing: Switch(
                value: _profile.tautulliEnabled ?? false,
                onChanged: (value) {
                    _profile.tautulliEnabled = value;
                    _profile.save(context: context);
                },
            ),
        ),
        LSCardTile(
            title: LSTitle(text: 'Host'),
            subtitle: LSSubtitle(
                text: _profile.tautulliHost == null || _profile.tautulliHost == ''
                    ? 'Not Set'
                    : _profile.tautulliHost
            ),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: _changeHost,
        ),
        LSCardTile(
            title: LSTitle(text: 'API Key'),
            subtitle: LSSubtitle(
                text: _profile.tautulliKey == null || _profile.tautulliKey == ''
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
    ];

    List<Widget> get _customization => [
        LSHeader(
            text: 'Customization',
            subtitle: 'Customize Tautulli to fit your needs',
        ),
        ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [TautulliDatabaseValue.NAVIGATION_INDEX.key]),
            builder: (context, box, _) => LSCardTile(
                title: LSTitle(text: 'Default Page'),
                subtitle: LSSubtitle(
                    text: TautulliNavigationBar.titles[TautulliDatabaseValue.NAVIGATION_INDEX.data],
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
            onTap: () async => Navigator.of(context).pushNamed(SettingsModulesTautulliHeaders.ROUTE_NAME),
        ),
        LSCardTile(
            title: LSTitle(text: 'Strict SSL/TLS Validation'),
            subtitle: LSSubtitle(text: 'For Invalid Certificates'),
            trailing: Switch(
                value: _profile.tautulliStrictTLS ?? true,
                onChanged: (value) async {
                    if(value) {
                        _profile.tautulliStrictTLS = value;
                        _profile.save(context: context);
                    } else {
                        List _values = await SettingsDialogs.toggleStrictTLS(context);
                        if(_values[0]) {
                            _profile.tautulliStrictTLS = value;
                            _profile.save(context: context);
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
        List<dynamic> _values = await SettingsDialogs.editHost(context, 'Tautulli Host', prefill: _profile.tautulliHost ?? '');
        if(_values[0]) {
            _profile.tautulliHost = _values[1];
            _profile.save(context: context);
        }
    }

    Future<void> _changeKey() async {
        List<dynamic> _values = await GlobalDialogs.editText(context, 'Tautulli API Key', prefill: _profile.tautulliKey ?? '');
        if(_values[0]) {
            _profile.tautulliKey = _values[1];
            _profile.save(context: context);
        }
    }

    Future<void> _defaultPage() async {
        List<dynamic> _values = await TautulliDialogs.defaultPage(context);
        if(_values[0]) TautulliDatabaseValue.NAVIGATION_INDEX.put(_values[1]);
    }

    Future<void> _testConnection() async {
        TautulliState state = Provider.of<TautulliState>(context, listen: false);
        if(!state.enabled) {
            LSSnackBar(context: context, title: 'Tautulli Not Enabled', message: 'Tautulli needs to be enabled', type: SNACKBAR_TYPE.failure);
            return;
        }
        if(_profile.tautulliHost == null || _profile.tautulliHost.isEmpty) {
            LSSnackBar(context: context, title: 'Host Required', message: 'Host is required to connect to Tautulli', type: SNACKBAR_TYPE.failure);
            return;
        }
        if(_profile.tautulliKey == null || _profile.tautulliKey.isEmpty) {
            LSSnackBar(context: context, title: 'API Key Required', message: 'API key is required to connect to Tautulli', type: SNACKBAR_TYPE.failure);
            return;
        }
        state.api.miscellaneous.arnold()
        .then((_) {
            LSSnackBar(context: context, title: 'Connected Successfully', message: 'Tautulli is ready to use with LunaSea', type: SNACKBAR_TYPE.success);
        }).catchError((error, trace) {
            Logger.error('SettingsModulesTautulli', '_testConnection', 'Failed Connection', error, trace, uploadToSentry: false);
            LSSnackBar(context: context, title: 'Connection Test Failed', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure);
        });
    }
}
