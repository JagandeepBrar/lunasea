import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sabnzbd.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesSABnzbd extends StatefulWidget {
    static const ROUTE_NAME = '/settings/modules/sabnzbd';
    
    @override
    State<SettingsModulesSABnzbd> createState() => _State();
}

class _State extends State<SettingsModulesSABnzbd> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    ProfileHiveObject _profile = Database.currentProfileObject;

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        body: _body,
        appBar: _appBar,
    );

    Widget get _appBar => LSAppBar(title: 'SABnzbd');

    List<Widget> get _configuration => [
        LSHeader(
            text: 'Configuration',
            subtitle: 'Mandatory configuration for SABnzbd functionality',
        ),
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
        LSDivider(),
        LSButton(
            text: 'Test Connection',
            onTap: _testConnection,
        ),
    ];

    List<Widget> get _customization => [
        LSHeader(
            text: 'Customization',
            subtitle: 'Customize SABnzbd to fit your needs',
        ),
        ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [SABnzbdDatabaseValue.NAVIGATION_INDEX.key]),
            builder: (context, box, _) => LSCardTile(
                title: LSTitle(text: 'Default Page'),
                subtitle: LSSubtitle(
                    text: SABnzbdNavigationBar.titles[SABnzbdDatabaseValue.NAVIGATION_INDEX.data],
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
            onTap: () async => Navigator.of(context).pushNamed(SettingsModulesSABnzbdHeaders.ROUTE_NAME),
        ),
        LSCardTile(
            title: LSTitle(text: 'Strict SSL/TLS Validation'),
            subtitle: LSSubtitle(text: 'For Invalid Certificates'),
            trailing: Switch(
                value: _profile.sabnzbdStrictTLS ?? true,
                onChanged: (value) async {
                    if(value) {
                        _profile.sabnzbdStrictTLS = value;
                        _profile.save();
                    } else {
                        List _values = await SettingsDialogs.toggleStrictTLS(context);
                        if(_values[0]) {
                            _profile.sabnzbdStrictTLS = value;
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
        List<dynamic> _values = await SettingsDialogs.editHost(context, 'SABnzbd Host', prefill: _profile.sabnzbdHost ?? '');
        if(_values[0]) {
            _profile.sabnzbdHost = _values[1];
            _profile.save();
        }
    }

    Future<void> _changeKey() async {
        List<dynamic> _values = await GlobalDialogs.editText(context, 'SABnzbd API Key', prefill: _profile.sabnzbdKey ?? '');
        if(_values[0]) {
            _profile.sabnzbdKey = _values[1];
            _profile.save();
        }
    }

    Future<void> _defaultPage() async {
        List<dynamic> _values = await SABnzbdDialogs.defaultPage(context);
        if(_values[0]) SABnzbdDatabaseValue.NAVIGATION_INDEX.put(_values[1]);
    }

    Future<void> _testConnection() async => await SABnzbdAPI.from(_profile).testConnection()
        ? LSSnackBar(context: context, title: 'Connected Successfully', message: 'SABnzbd is ready to use with LunaSea', type: SNACKBAR_TYPE.success)
        : LSSnackBar(context: context, title: 'Connection Test Failed', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure);
}
