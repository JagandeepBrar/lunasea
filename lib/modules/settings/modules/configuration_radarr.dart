import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationRadarrRouter extends LunaPageRouter {
    SettingsConfigurationRadarrRouter() : super('/settings/configuration/radarr');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationRadarrRoute());
}

class _SettingsConfigurationRadarrRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationRadarrRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationRadarrRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Radarr',
        actions: [_helpMessageButton],
    );
    
    Widget get _helpMessageButton => LSIconButton(
        icon: Icons.help_outline,
        onPressed: () async => SettingsDialogs.helpMessage(
            context,
            title: RadarrConstants.MODULE_MAP.name,
            message: RadarrConstants.MODULE_MAP.helpMessage,
            github: RadarrConstants.MODULE_MAP.github,
            website: RadarrConstants.MODULE_MAP.website,
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
        title: LSTitle(text: 'Enable Radarr'),
        trailing: Switch(
            value: Database.currentProfileObject.radarrEnabled ?? false,
            onChanged: (value) {
                Database.currentProfileObject.radarrEnabled = value;
                Database.currentProfileObject.save();
            },
        ),
    );

    Widget get _hostTile {
        Future<void> _execute() async {
            List<dynamic> _values = await SettingsDialogs.editHost(
                context,
                'Radarr Host',
                prefill: Database.currentProfileObject.radarrHost ?? '',
            );
            if(_values[0]) {
                Database.currentProfileObject.radarrHost = _values[1];
                Database.currentProfileObject.save();
            }
        }
        return LSCardTile(
            title: LSTitle(text: 'Host'),
            subtitle: LSSubtitle(
                text: Database.currentProfileObject.radarrHost == null || Database.currentProfileObject.radarrHost == ''
                    ? 'Not Set'
                    : Database.currentProfileObject.radarrHost
                ),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: _execute,
        );
    }

    Widget get _apiKeyTile {
        Future<void> _execute() async {
            List<dynamic> _values = await LunaDialogs.editText(
                context,
                'Radarr API Key',
                prefill: Database.currentProfileObject.radarrKey ?? '',
            );
            if(_values[0]) {
                Database.currentProfileObject.radarrKey = _values[1];
                Database.currentProfileObject.save();
            }
        }
        return LSCardTile(
            title: LSTitle(text: 'API Key'),
            subtitle: LSSubtitle(
                text: Database.currentProfileObject.radarrKey == null || Database.currentProfileObject.radarrKey == ''
                    ? 'Not Set'
                    : '••••••••••••'
            ),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: _execute,
        );
    }

    Widget get _testConnectionTile {
        Future<void> _testConnection(BuildContext context) async => await RadarrAPI.from(Database.currentProfileObject).testConnection()
        .then((_) => showLunaSuccessSnackBar(
            context: context,
            title: 'Connected Successfully',
            message: 'Radarr is ready to use with LunaSea',
        ))
        .catchError((error, stack) {
            LunaLogger.error(
                '_SettingsConfigurationRadarrRoute',
                '_testConnectionTile',
                'Connection Test Failed',
                error,
                stack,
                uploadToSentry: false,
            );
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
        onTap: () async => SettingsConfigurationRadarrHeadersRouter().navigateTo(context),
    );

    Widget get _configDefaultPageTile {
        Future<void> _execute() async {
            List<dynamic> _values = await RadarrDialogs.defaultPage(context);
            if(_values[0]) RadarrDatabaseValue.NAVIGATION_INDEX.put(_values[1]);
        }
        return ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [RadarrDatabaseValue.NAVIGATION_INDEX.key]),
            builder: (context, box, _) => LSCardTile(
                title: LSTitle(text: 'Default Page'),
                subtitle: LSSubtitle(text: RadarrNavigationBar.titles[RadarrDatabaseValue.NAVIGATION_INDEX.data]),
                trailing: LSIconButton(icon: RadarrNavigationBar.icons[RadarrDatabaseValue.NAVIGATION_INDEX.data]),
                onTap: _execute,
            ),
        );
    }
}
