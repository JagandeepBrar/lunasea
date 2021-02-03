import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sabnzbd.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationSABnzbdRouter extends LunaPageRouter {
    SettingsConfigurationSABnzbdRouter() : super('/settings/configuration/sabnzbd');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationSABnzbdRoute());
}

class _SettingsConfigurationSABnzbdRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationSABnzbdRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationSABnzbdRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'SABnzbd',
        actions: [_helpMessageButton],
    );
    
    Widget get _helpMessageButton => LSIconButton(
        icon: Icons.help_outline,
        onPressed: () async => SettingsDialogs.helpMessage(
            context,
            title: SABnzbdConstants.MODULE_METADATA.name,
            message: SABnzbdConstants.MODULE_METADATA.helpMessage,
            github: SABnzbdConstants.MODULE_METADATA.github,
            website: SABnzbdConstants.MODULE_METADATA.website,
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

    Widget get _enabledTile => LSCardTile(
        title: LSTitle(text: 'Enable SABnzbd'),
        trailing: LunaSwitch(
            value: Database.currentProfileObject.sabnzbdEnabled ?? false,
            onChanged: (value) {
                Database.currentProfileObject.sabnzbdEnabled = value;
                Database.currentProfileObject.save();
            },
        ),
    );

    Widget get _hostTile {
        Future<void> _execute() async {
            List<dynamic> _values = await SettingsDialogs.editHost(context, 'SABnzbd Host', prefill: Database.currentProfileObject.sabnzbdHost ?? '');
            if(_values[0]) {
                Database.currentProfileObject.sabnzbdHost = _values[1];
                Database.currentProfileObject.save();
            }
        }
        return LSCardTile(
            title: LSTitle(text: 'Host'),
            subtitle: LSSubtitle(
                text: Database.currentProfileObject.sabnzbdHost == null || Database.currentProfileObject.sabnzbdHost == ''
                    ? 'Not Set'
                    : Database.currentProfileObject.sabnzbdHost
                ),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: _execute,
        );
    }

    Widget get _apiKeyTile {
        Future<void> _execute() async {
            List<dynamic> _values = await LunaDialogs().editText(context, 'SABnzbd API Key', prefill: Database.currentProfileObject.sabnzbdKey ?? '');
            if(_values[0]) {
                Database.currentProfileObject.sabnzbdKey = _values[1];
                Database.currentProfileObject.save();
            }
        }
        return LSCardTile(
            title: LSTitle(text: 'API Key'),
            subtitle: LSSubtitle(
                text: Database.currentProfileObject.sabnzbdKey == null || Database.currentProfileObject.sabnzbdKey == ''
                    ? 'Not Set'
                    : '••••••••••••'
            ),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: _execute,
        );
    }

    Widget get _customHeadersTile => LSCardTile(
        title: LSTitle(text: 'Custom Headers'),
        subtitle: LSSubtitle(text: 'Add Custom Headers to Requests'),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => SettingsConfigurationSABnzbdHeadersRouter().navigateTo(context),
    );

    Widget get _testConnectionTile {
        Future<void> _testConnection(BuildContext context) async => await SABnzbdAPI.from(Database.currentProfileObject).testConnection()
        .then((response) {
            if((response as Response).data['status'] != false) {
                showLunaSuccessSnackBar(
                    context: context,
                    title: 'Connected Successfully',
                    message: 'SABnzbd is ready to use with ${Constants.APPLICATION_NAME}',
                );
            } else {
                showLunaErrorSnackBar(
                    context: context,
                    title: 'Connection Test Failed',
                    message: 'SABnzbd: ${(response as Response).data['error'] ?? Constants.TEXT_EMDASH}',
                );
            }
        })
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

    List<Widget> get _customization => [
        LSHeader(text: 'Default Pages'),
        _defaultPageTile,
    ];

    Widget get _defaultPageTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [SABnzbdDatabaseValue.NAVIGATION_INDEX.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Home'),
            subtitle: LSSubtitle(text: SABnzbdNavigationBar.titles[SABnzbdDatabaseValue.NAVIGATION_INDEX.data]),
            trailing: LSIconButton(icon: SABnzbdNavigationBar.icons[SABnzbdDatabaseValue.NAVIGATION_INDEX.data]),
            onTap: () async {
                List<dynamic> _values = await SABnzbdDialogs.defaultPage(context);
                if(_values[0]) SABnzbdDatabaseValue.NAVIGATION_INDEX.put(_values[1]);
            },
        ),
    );
}
