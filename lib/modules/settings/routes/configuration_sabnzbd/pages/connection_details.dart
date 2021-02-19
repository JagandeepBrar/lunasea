import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sabnzbd.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationSABnzbdConnectionDetailsRouter extends LunaPageRouter {
    SettingsConfigurationSABnzbdConnectionDetailsRouter() : super('/settings/configuration/sabnzbd/connection');

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
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar(),
            body: _body(),
        );
    }

    Widget _appBar() => LunaAppBar(title: 'Connection Details');

    Widget _body() {
        return ValueListenableBuilder(
            valueListenable: Database.profilesBox.listenable(),
            builder: (context, box, _) => LunaListView(
                children: [
                    _host(),
                    _apiKey(),
                    _customHeaders(),
                    _testConnection(),
                ],
            ),
        );
    }

    Widget _host() {
        String host = Database.currentProfileObject.sabnzbdHost;
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Host'),
            subtitle: LunaText.subtitle(text: (host ?? '').isEmpty ? 'Not Set' : host),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async {
                List<dynamic> _values = await SettingsDialogs.editHost(context, 'SABnzbd Host', prefill: Database.currentProfileObject.sabnzbdHost ?? '');
                if(_values[0]) {
                    Database.currentProfileObject.sabnzbdHost = _values[1];
                    Database.currentProfileObject.save();
                    context.read<SABnzbdState>().reset();
                }
            },
        );
    }

    Widget _apiKey() {
        String apiKey = Database.currentProfileObject.sabnzbdKey;
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'API Key'),
            subtitle: LunaText.subtitle(text: (apiKey ?? '').isEmpty ? 'Not Set' : '••••••••••••'),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async {
                List<dynamic> _values = await LunaDialogs().editText(context, 'SABnzbd API Key', prefill: Database.currentProfileObject.sabnzbdKey ?? '');
                if(_values[0]) {
                    Database.currentProfileObject.sabnzbdKey = _values[1];
                    Database.currentProfileObject.save();
                    context.read<SABnzbdState>().reset();
                }
            },
        );
    }

    Widget _testConnection() {
        return LunaButtonContainer(
            children: [
                LunaButton(
                    text: 'Test Connection',
                    onTap: () async {
                        ProfileHiveObject _profile = Database.currentProfileObject;
                        if(_profile.sabnzbdHost == null || _profile.sabnzbdHost.isEmpty) {
                            showLunaErrorSnackBar(
                                context: context,
                                title: 'Host Required',
                                message: 'Host is required to connect to SABnzbd',
                            );
                            return;
                        }
                        if(_profile.sabnzbdKey == null || _profile.sabnzbdKey.isEmpty) {
                            showLunaErrorSnackBar(
                                context: context,
                                title: 'API Key Required',
                                message: 'API key is required to connect to SABnzbd',
                            );
                            return;
                        }
                        SABnzbdAPI.from(Database.currentProfileObject).testConnection()
                        .then((_) => showLunaSuccessSnackBar(
                            context: context,
                            title: 'Connected Successfully',
                            message: 'SABnzbd is ready to use with ${Constants.APPLICATION_NAME}',
                        )).catchError((error, trace) {
                            LunaLogger().error('Connection Test Failed', error, trace);
                            showLunaErrorSnackBar(
                                context: context,
                                title: 'Connection Test Failed',
                                error: error,
                            );
                        });
                    },
                ),
            ],
        );
    }

    Widget _customHeaders() {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Custom Headers'),
            subtitle: LunaText.subtitle(text: 'Add Custom Headers to Requests'),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async => SettingsConfigurationSABnzbdHeadersRouter().navigateTo(context),
        );
    }
}
