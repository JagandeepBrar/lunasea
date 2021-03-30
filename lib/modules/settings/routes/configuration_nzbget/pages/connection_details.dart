import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/nzbget.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationNZBGetConnectionDetailsRouter extends SettingsPageRouter {
    SettingsConfigurationNZBGetConnectionDetailsRouter() : super('/settings/configuration/nzbget/connection');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationNZBGetRoute());
}

class _SettingsConfigurationNZBGetRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationNZBGetRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationNZBGetRoute> with LunaScrollControllerMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar(),
            body: _body(),
            bottomNavigationBar: _bottomActionBar(),
        );
    }

    Widget _appBar() {
        return LunaAppBar(
            title: 'Connection Details',
            scrollControllers: [scrollController],
        );
    }

    Widget _bottomActionBar() {
        return LunaBottomActionBar(
            actions: [
                _testConnection(),
            ],
        );
    }

    Widget _body() {
        return ValueListenableBuilder(
            valueListenable: Database.profilesBox.listenable(),
            builder: (context, box, _) => LunaListView(
                controller: scrollController,
                children: [
                    _host(),
                    _username(),
                    _password(),
                    _customHeaders(),
                ],
            ),
        );
    }

    Widget _host() {
        String host = Database.currentProfileObject.nzbgetHost;
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Host'),
            subtitle: LunaText.subtitle(text: (host ?? '').isEmpty ? 'Not Set' : host),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
            onTap: () async {
                List<dynamic> _values = await SettingsDialogs.editHost(context, 'NZBGet Host', prefill: Database.currentProfileObject.nzbgetHost ?? '');
                if(_values[0]) {
                    Database.currentProfileObject.nzbgetHost = _values[1];
                    Database.currentProfileObject.save();
                    context.read<NZBGetState>().reset();
                }
            },
        );
    }

    Widget _username() {
        String username = Database.currentProfileObject.nzbgetUser;
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Username'),
            subtitle: LunaText.subtitle(text: (username ?? '').isEmpty ? 'Not Set' : username),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
            onTap: () async {
                Tuple2<bool, String> _values = await LunaDialogs().editText(context, 'NZBGet Username', prefill: Database.currentProfileObject.nzbgetUser ?? '');
                if(_values.item1) {
                    Database.currentProfileObject.nzbgetUser = _values.item2;
                    Database.currentProfileObject.save();
                    context.read<NZBGetState>().reset();
                }
            },
        );
    }

    Widget _password() {
        String password = Database.currentProfileObject.nzbgetPass;
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Password'),
            subtitle: LunaText.subtitle(text: (password ?? '').isEmpty ? 'Not Set' : '••••••••••••'),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
            onTap: () async {
                Tuple2<bool, String> _values = await LunaDialogs().editText(
                    context,
                    'NZBGet Password',
                    prefill: Database.currentProfileObject.nzbgetPass ?? '',
                    extraText: [
                        LSDialog.textSpanContent(text: '${LunaUI.TEXT_BULLET}\tIf your password includes special characters, considering adding a '),
                        LSDialog.bolded(text: 'basic authentication'),
                        LSDialog.textSpanContent(text: ' header with your username and password instead for better support'),
                    ],
                );
                if(_values.item1) {
                    Database.currentProfileObject.nzbgetPass = _values.item2;
                    Database.currentProfileObject.save();
                    context.read<NZBGetState>().reset();
                }
            },
        );
    }

    Widget _testConnection() {
        return LunaButton.text(
            text: 'Test Connection',
            icon: Icons.wifi_tethering_rounded,
            onTap: () async {
                ProfileHiveObject _profile = Database.currentProfileObject;
                if(_profile.nzbgetHost == null || _profile.nzbgetHost.isEmpty) {
                    showLunaErrorSnackBar(
                        title: 'Host Required',
                        message: 'Host is required to connect to NZBGet',
                    );
                    return;
                }
                NZBGetAPI.from(Database.currentProfileObject).testConnection()
                .then((_) => showLunaSuccessSnackBar(
                    title: 'Connected Successfully',
                    message: 'NZBGet is ready to use with LunaSea',
                )).catchError((error, trace) {
                    LunaLogger().error('Connection Test Failed', error, trace);
                    showLunaErrorSnackBar(
                        title: 'Connection Test Failed',
                        error: error,
                    );
                });
            },
        );
    }

    Widget _customHeaders() {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Custom Headers'),
            subtitle: LunaText.subtitle(text: 'Add Custom Headers to Requests'),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
            onTap: () async => SettingsConfigurationNZBGetHeadersRouter().navigateTo(context),
        );
    }
}
