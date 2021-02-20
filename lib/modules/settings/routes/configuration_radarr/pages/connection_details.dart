import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationRadarrConnectionDetailsRouter extends LunaPageRouter {
    SettingsConfigurationRadarrConnectionDetailsRouter() : super('/settings/configuration/radarr/connection');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationRadarrRoute());
}

class _SettingsConfigurationRadarrRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationRadarrRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationRadarrRoute> with LunaScrollControllerMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar(),
            body: _body(),
        );
    }

    Widget _appBar() => LunaAppBar(title: 'Connection Details', scrollControllers: [scrollController]);

    Widget _body() {
        return ValueListenableBuilder(
            valueListenable: Database.profilesBox.listenable(),
            builder: (context, box, _) => LunaListView(
                controller: scrollController,
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
        String host = Database.currentProfileObject.radarrHost;
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Host'),
            subtitle: LunaText.subtitle(text: (host ?? '').isEmpty ? 'Not Set' : host),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async {
                List<dynamic> _values = await SettingsDialogs.editHost(context, 'Radarr Host', prefill: Database.currentProfileObject.radarrHost ?? '');
                if(_values[0]) {
                    Database.currentProfileObject.radarrHost = _values[1];
                    Database.currentProfileObject.save();
                    context.read<RadarrState>().reset();
                }
            },
        );
    }

    Widget _apiKey() {
        String apiKey = Database.currentProfileObject.radarrKey;
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'API Key'),
            subtitle: LunaText.subtitle(text: (apiKey ?? '').isEmpty ? 'Not Set' : '••••••••••••'),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async {
                List<dynamic> _values = await LunaDialogs().editText(context, 'Radarr API Key', prefill: Database.currentProfileObject.radarrKey ?? '');
                if(_values[0]) {
                    Database.currentProfileObject.radarrKey = _values[1];
                    Database.currentProfileObject.save();
                    context.read<RadarrState>().reset();
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
                        if(_profile.radarrHost == null || _profile.radarrHost.isEmpty) {
                            showLunaErrorSnackBar(
                                context: context,
                                title: 'Host Required',
                                message: 'Host is required to connect to Radarr',
                            );
                            return;
                        }
                        if(_profile.radarrKey == null || _profile.radarrKey.isEmpty) {
                            showLunaErrorSnackBar(
                                context: context,
                                title: 'API Key Required',
                                message: 'API key is required to connect to Radarr',
                            );
                            return;
                        }
                        Radarr(host: _profile.radarrHost, apiKey: _profile.radarrKey, headers: Map<String, dynamic>.from(_profile.radarrHeaders))
                        .system.status().then((_) => showLunaSuccessSnackBar(
                            context: context,
                            title: 'Connected Successfully',
                            message: 'Radarr is ready to use with ${Constants.APPLICATION_NAME}',
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
            onTap: () async => SettingsConfigurationRadarrHeadersRouter().navigateTo(context),
        );
    }
}
