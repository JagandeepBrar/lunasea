import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationSonarrConnectionDetailsRouter
    extends SettingsPageRouter {
  SettingsConfigurationSonarrConnectionDetailsRouter()
      : super('/settings/configuration/sonarr/connection');

  @override
  _Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) =>
      super.noParameterRouteDefinition(router);
}

class _Widget extends StatefulWidget {
  @override
  State<_Widget> createState() => _State();
}

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
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
          _enableVersion3(),
          _host(),
          _apiKey(),
          _customHeaders(),
        ],
      ),
    );
  }

  Widget _enableVersion3() {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'Sonarr v3'),
      subtitle: LunaText.subtitle(text: 'Enable Support for Sonarr v3'),
      trailing: LunaSwitch(
        value: Database.currentProfileObject.sonarrVersion3 ?? false,
        onChanged: (value) {
          Database.currentProfileObject.sonarrVersion3 = value;
          Database.currentProfileObject.save();
          context.read<SonarrState>().reset();
        },
      ),
    );
  }

  Widget _host() {
    String host = Database.currentProfileObject.sonarrHost;
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'Host'),
      subtitle:
          LunaText.subtitle(text: (host ?? '').isEmpty ? 'Not Set' : host),
      trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
      onTap: () async {
        Tuple2<bool, String> _values = await SettingsDialogs().editHost(
          context,
          prefill: Database.currentProfileObject.sonarrHost ?? '',
        );
        if (_values.item1) {
          Database.currentProfileObject.sonarrHost = _values.item2;
          Database.currentProfileObject.save();
          context.read<SonarrState>().reset();
        }
      },
    );
  }

  Widget _apiKey() {
    String apiKey = Database.currentProfileObject.sonarrKey;
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'API Key'),
      subtitle: LunaText.subtitle(
          text: (apiKey ?? '').isEmpty ? 'Not Set' : '••••••••••••'),
      trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
      onTap: () async {
        Tuple2<bool, String> _values = await LunaDialogs().editText(
            context, 'Sonarr API Key',
            prefill: Database.currentProfileObject.sonarrKey ?? '');
        if (_values.item1) {
          Database.currentProfileObject.sonarrKey = _values.item2;
          Database.currentProfileObject.save();
          context.read<SonarrState>().reset();
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
        if (_profile.sonarrHost == null || _profile.sonarrHost.isEmpty) {
          showLunaErrorSnackBar(
            title: 'Host Required',
            message: 'Host is required to connect to Sonarr',
          );
          return;
        }
        if (_profile.sonarrKey == null || _profile.sonarrKey.isEmpty) {
          showLunaErrorSnackBar(
            title: 'API Key Required',
            message: 'API key is required to connect to Sonarr',
          );
          return;
        }
        Sonarr(
                host: _profile.sonarrHost,
                apiKey: _profile.sonarrKey,
                headers: Map<String, dynamic>.from(_profile.sonarrHeaders))
            .system
            .getStatus()
            .then((_) => showLunaSuccessSnackBar(
                  title: 'Connected Successfully',
                  message: 'Sonarr is ready to use with LunaSea',
                ))
            .catchError((error, trace) {
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
      onTap: () async =>
          SettingsConfigurationSonarrHeadersRouter().navigateTo(context),
    );
  }
}
