import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/nzbget.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationNZBGetRouter extends LunaPageRouter {
    SettingsConfigurationNZBGetRouter() : super('/settings/configuration/nzbget');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationNZBGetRoute());
}

class _SettingsConfigurationNZBGetRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationNZBGetRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationNZBGetRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'NZBGet',
        actions: [_helpMessageButton],
    );
    
    Widget get _helpMessageButton => LSIconButton(
        icon: Icons.help_outline,
        onPressed: () async => SettingsDialogs.helpMessage(
            context,
            title: NZBGetConstants.MODULE_METADATA.name,
            message: NZBGetConstants.MODULE_METADATA.helpMessage,
            github: NZBGetConstants.MODULE_METADATA.github,
            website: NZBGetConstants.MODULE_METADATA.website,
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
        _usernameTile,
        _passwordTile,
        _customHeadersTile,
        _testConnectionTile,
    ];

    Widget get _enabledTile => LSCardTile(
        title: LSTitle(text: 'Enable NZBGet'),
        trailing: Switch(
            value: Database.currentProfileObject.nzbgetEnabled ?? false,
            onChanged: (value) {
                Database.currentProfileObject.nzbgetEnabled = value;
                Database.currentProfileObject.save();
            },
        ),
    );

    Widget get _hostTile {
        Future<void> _execute() async {
            List<dynamic> _values = await SettingsDialogs.editHost(context, 'NZBGet Host', prefill: Database.currentProfileObject.nzbgetHost ?? '');
            if(_values[0]) {
                Database.currentProfileObject.nzbgetHost = _values[1];
                Database.currentProfileObject.save();
            }
        }
        return LSCardTile(
            title: LSTitle(text: 'Host'),
            subtitle: LSSubtitle(
                text: Database.currentProfileObject.nzbgetHost == null || Database.currentProfileObject.nzbgetHost == ''
                    ? 'Not Set'
                    : Database.currentProfileObject.nzbgetHost
                ),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: _execute,
        );
    }

    Widget get _usernameTile {
        Future<void> _execute() async {
            List<dynamic> _values = await LunaDialogs.editText(context, 'NZBGet Username', prefill: Database.currentProfileObject.nzbgetUser ?? '');
            if(_values[0]) {
                Database.currentProfileObject.nzbgetUser = _values[1];
                Database.currentProfileObject.save();
            }
        }
        return LSCardTile(
            title: LSTitle(text: 'Username'),
            subtitle: LSSubtitle(
                text: Database.currentProfileObject.nzbgetUser == null || Database.currentProfileObject.nzbgetUser == ''
                    ? 'Not Set'
                    : Database.currentProfileObject.nzbgetUser
            ),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: _execute,
        );
    }

    Widget get _passwordTile {
        Future<void> _execute() async {
            List<dynamic> _values = await LunaDialogs.editText(
                context,
                'NZBGet Password',
                prefill: Database.currentProfileObject.nzbgetPass ?? '',
                extraText: [
                    LSDialog.textSpanContent(text: '${Constants.TEXT_BULLET}\tIf your password includes special characters, considering adding a '),
                    LSDialog.bolded(text: 'basic authentication'),
                    LSDialog.textSpanContent(text: ' header with your username and password instead for better support'),
                ],
            );
            if(_values[0]) {
                Database.currentProfileObject.nzbgetPass = _values[1];
                Database.currentProfileObject.save();
            }
        }
        return LSCardTile(
            title: LSTitle(text: 'Password'),
            subtitle: LSSubtitle(
                text: Database.currentProfileObject.nzbgetPass == null || Database.currentProfileObject.nzbgetPass == ''
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
        onTap: () async => SettingsConfigurationNZBGetHeadersRouter().navigateTo(context),
    );

    Widget get _testConnectionTile {
        Future<void> _testConnection(BuildContext context) async => await NZBGetAPI.from(Database.currentProfileObject).testConnection()
        .then((_) => showLunaSuccessSnackBar(
            context: context,
            title: 'Connected Successfully',
            message: 'NZBGet is ready to use with LunaSea',
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

    List<Widget> get _customization => [
        LSHeader(text: 'Default Pages'),
        _defaultPageTile,
    ];

    Widget get _defaultPageTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [NZBGetDatabaseValue.NAVIGATION_INDEX.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Home'),
            subtitle: LSSubtitle(text: NZBGetNavigationBar.titles[NZBGetDatabaseValue.NAVIGATION_INDEX.data]),
            trailing: LSIconButton(icon: NZBGetNavigationBar.icons[NZBGetDatabaseValue.NAVIGATION_INDEX.data]),
            onTap: () async {
                List<dynamic> _values = await NZBGetDialogs.defaultPage(context);
                if(_values[0]) NZBGetDatabaseValue.NAVIGATION_INDEX.put(_values[1]);
            },
        ),
    );
}
