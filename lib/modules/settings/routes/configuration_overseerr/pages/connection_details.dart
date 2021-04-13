import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/overseerr.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationOverseerrConnectionDetailsRouter extends SettingsPageRouter {
    SettingsConfigurationOverseerrConnectionDetailsRouter() : super('/settings/configuration/overseerr/connection');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationOverseerrRoute());
}

class _SettingsConfigurationOverseerrRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationOverseerrRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationOverseerrRoute> with LunaScrollControllerMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
        return  LunaScaffold(
            scaffoldKey: _scaffoldKey,
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
                    _apiKey(),
                    _customHeaders(),
                ],
            ),
        );
    }

    Widget _host() {
        String host = Database.currentProfileObject.overseerrHost;
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Host'),
            subtitle: LunaText.subtitle(text: (host ?? '').isEmpty ? 'Not Set' : host),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
            onTap: () async {
                List<dynamic> _values = await SettingsDialogs.editHost(context, 'Overseerr Host', prefill: Database.currentProfileObject.overseerrHost ?? '');
                if(_values[0]) {
                    Database.currentProfileObject.overseerrHost = _values[1];
                    Database.currentProfileObject.save();
                    context.read<OverseerrState>().reset();
                }
            },
        );
    }

    Widget _apiKey() {
        String apiKey = Database.currentProfileObject.overseerrKey;
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'API Key'),
            subtitle: LunaText.subtitle(text: (apiKey ?? '').isEmpty ? 'Not Set' : '••••••••••••'),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
            onTap: () async {
                Tuple2<bool, String> _values = await LunaDialogs().editText(context, 'Overseerr API Key', prefill: Database.currentProfileObject.overseerrKey ?? '');
                if(_values.item1) {
                    Database.currentProfileObject.overseerrKey = _values.item2;
                    Database.currentProfileObject.save();
                    context.read<OverseerrState>().reset();
                }
            },
        );
    }

    Widget _testConnection() {
        return LunaButton.text(
            text: 'Test Connection',
            icon: Icons.wifi_tethering_rounded,
            onTap: () async {},
        );
    }

    Widget _customHeaders() {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Custom Headers'),
            subtitle: LunaText.subtitle(text: 'Add Custom Headers to Requests'),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
            onTap: () async => SettingsConfigurationOverseerrHeadersRouter().navigateTo(context),
        );
    }
}
