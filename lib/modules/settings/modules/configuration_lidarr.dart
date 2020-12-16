import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationLidarrRouter extends LunaPageRouter {
    SettingsConfigurationLidarrRouter() : super('/settings/configuration/lidarr');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationLidarrRoute());
}

class _SettingsConfigurationLidarrRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationLidarrRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationLidarrRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Lidarr',
        actions: [_helpMessageButton],
    );
    
    Widget get _helpMessageButton => LSIconButton(
        icon: Icons.help_outline,
        onPressed: () async => SettingsDialogs.helpMessage(
            context,
            title: LidarrConstants.MODULE_METADATA.name,
            message: LidarrConstants.MODULE_METADATA.helpMessage,
            github: LidarrConstants.MODULE_METADATA.github,
            website: LidarrConstants.MODULE_METADATA.website,
        ),
    );

    Widget get _body => ValueListenableBuilder(
        valueListenable: Database.profilesBox.listenable(),
        builder: (context, box, _) => LSListView(
            children: [
                ..._configuration,
                ..._customization,
            ],
        ),
    );

    List<Widget> get _configuration => [
        _enabledTile,
        _hostTile,
        _apiKeyTile,
        _customHeadersTile,
        _testConnectionTile,
    ];

    List<Widget> get _customization => [
        LSHeader(text: 'Default Pages'),
        _configDefaultPageTile,
    ];

    Widget get _enabledTile => LSCardTile(
        title: LSTitle(text: 'Enable Lidarr'),
        trailing: Switch(
            value: Database.currentProfileObject.lidarrEnabled ?? false,
            onChanged: (value) {
                Database.currentProfileObject.lidarrEnabled = value;
                Database.currentProfileObject.save();
            },
        ),
    );

    Widget get _hostTile {
        Future<void> _execute() async {
            List<dynamic> _values = await SettingsDialogs.editHost(
                context,
                'Lidarr Host',
                prefill: Database.currentProfileObject.lidarrHost ?? '',
            );
            if(_values[0]) {
                Database.currentProfileObject.lidarrHost = _values[1];
                Database.currentProfileObject.save();
            }
        }
        return LSCardTile(
            title: LSTitle(text: 'Host'),
            subtitle: LSSubtitle(
                text: Database.currentProfileObject.lidarrHost == null || Database.currentProfileObject.lidarrHost == ''
                    ? 'Not Set'
                    : Database.currentProfileObject.lidarrHost
                ),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: _execute,
        );
    }

    Widget get _apiKeyTile {
        Future<void> _execute() async {
            List<dynamic> _values = await LunaDialogs.editText(
                context,
                'Lidarr API Key',
                prefill: Database.currentProfileObject.lidarrKey ?? '',
            );
            if(_values[0]) {
                Database.currentProfileObject.lidarrKey = _values[1];
                Database.currentProfileObject.save();
            }
        }
        return LSCardTile(
            title: LSTitle(text: 'API Key'),
            subtitle: LSSubtitle(
                text: Database.currentProfileObject.lidarrKey == null || Database.currentProfileObject.lidarrKey == ''
                    ? 'Not Set'
                    : '••••••••••••'
            ),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: _execute,
        );
    }

    Widget get _testConnectionTile {
        Future<void> _testConnection(BuildContext context) async => await LidarrAPI.from(Database.currentProfileObject).testConnection()
        .then((_) => showLunaSuccessSnackBar(
            context: context,
            title: 'Connected Successfully',
            message: 'Lidarr is ready to use with LunaSea',
        ))
        .catchError((error, stack) {
            LunaLogger().error('Connection Test Failed', error, stack);
            showLunaErrorSnackBar(
                context: context,
                title: 'Connection Test Failed',
                error: error,
            );
        }); 
        return LSButton(
            text: 'Test Connection',
            onTap: () async => _testConnection(context),
        );
    }

    Widget get _customHeadersTile => LSCardTile(
        title: LSTitle(text: 'Custom Headers'),
        subtitle: LSSubtitle(text: 'Add Custom Headers to Requests'),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => SettingsConfigurationLidarrHeadersRouter().navigateTo(context),
    );

    Widget get _configDefaultPageTile {
        Future<void> _execute() async {
            List<dynamic> _values = await LidarrDialogs.defaultPage(context);
            if(_values[0]) LidarrDatabaseValue.NAVIGATION_INDEX.put(_values[1]);
        }
        return ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [LidarrDatabaseValue.NAVIGATION_INDEX.key]),
            builder: (context, box, _) => LSCardTile(
                title: LSTitle(text: 'Default Page'),
                subtitle: LSSubtitle(text: LidarrNavigationBar.titles[LidarrDatabaseValue.NAVIGATION_INDEX.data]),
                trailing: LSIconButton(icon: LidarrNavigationBar.icons[LidarrDatabaseValue.NAVIGATION_INDEX.data]),
                onTap: _execute,
            ),
        );
    }
}
