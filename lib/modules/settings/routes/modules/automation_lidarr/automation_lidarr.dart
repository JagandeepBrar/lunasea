import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesLidarr extends StatefulWidget {
    static const ROUTE_NAME = '/settings/modules/lidarr';
    
    @override
    State<SettingsModulesLidarr> createState() => _State();
}

class _State extends State<SettingsModulesLidarr> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    ProfileHiveObject _profile = Database.currentProfileObject;

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        body: _body,
        appBar: _appBar,
    );

    Widget get _appBar => LSAppBar(title: 'Lidarr');

    List<Widget> get _configuration => [
        LSHeader(
            text: 'Configuration',
            subtitle: 'Mandatory configuration for Lidarr functionality',
        ),
        LSCardTile(
            title: LSTitle(text: 'Enable Lidarr'),
            subtitle: null,
            trailing: Switch(
                value: _profile.lidarrEnabled ?? false,
                onChanged: (value) {
                    _profile.lidarrEnabled = value;
                    _profile.save();
                },
            ),
        ),
        LSCardTile(
            title: LSTitle(text: 'Host'),
            subtitle: LSSubtitle(
                text: _profile.lidarrHost == null || _profile.lidarrHost == ''
                    ? 'Not Set'
                    : _profile.lidarrHost
            ),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: _changeHost,
        ),
        LSCardTile(
            title: LSTitle(text: 'API Key'),
            subtitle: LSSubtitle(
                text: _profile.lidarrKey == null || _profile.lidarrKey == ''
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
            subtitle: 'Customize Lidarr to fit your needs',
        ),
        ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [LidarrDatabaseValue.NAVIGATION_INDEX.key]),
            builder: (context, box, _) => LSCardTile(
                title: LSTitle(text: 'Default Page'),
                subtitle: LSSubtitle(
                    text: LidarrNavigationBar.titles[LidarrDatabaseValue.NAVIGATION_INDEX.data],
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
            onTap: () async => Navigator.of(context).pushNamed(SettingsModulesLidarrHeaders.ROUTE_NAME),
        ),
        LSCardTile(
            title: LSTitle(text: 'Strict SSL/TLS Validation'),
            subtitle: LSSubtitle(text: 'For Invalid Certificates'),
            trailing: Switch(
                value: _profile.lidarrStrictTLS ?? true,
                onChanged: (value) async {
                    if(value) {
                        _profile.lidarrStrictTLS = value;
                        _profile.save();
                    } else {
                        List _values = await SettingsDialogs.toggleStrictTLS(context);
                        if(_values[0]) {
                            _profile.lidarrStrictTLS = value;
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
        List<dynamic> _values = await SettingsDialogs.editHost(context, 'Lidarr Host', prefill: _profile.lidarrHost ?? '');
        if(_values[0]) {
            _profile.lidarrHost = _values[1];
            _profile.save();
        }
    }

    Future<void> _changeKey() async {
        List<dynamic> _values = await GlobalDialogs.editText(context, 'Lidarr API Key', prefill: _profile.lidarrKey ?? '');
        if(_values[0]) {
            _profile.lidarrKey = _values[1];
            _profile.save();
        }
    }

    Future<void> _defaultPage() async {
        List<dynamic> _values = await LidarrDialogs.defaultPage(context);
        if(_values[0]) LidarrDatabaseValue.NAVIGATION_INDEX.put(_values[1]);
    }

    Future<void> _testConnection() async => await LidarrAPI.from(_profile).testConnection()
        ? LSSnackBar(context: context, title: 'Connected Successfully', message: 'Lidarr is ready to use with LunaSea', type: SNACKBAR_TYPE.success)
        : LSSnackBar(context: context, title: 'Connection Test Failed', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure);
}
