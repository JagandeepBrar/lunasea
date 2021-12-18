import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/modules/sonarr.dart';

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
          _host(),
          _apiKey(),
          _customHeaders(),
        ],
      ),
    );
  }

  Widget _host() {
    String host = Database.currentProfileObject.sonarrHost ?? '';
    return LunaBlock(
      title: 'settings.Host'.tr(),
      body: [TextSpan(text: host.isEmpty ? 'lunasea.NotSet'.tr() : host)],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> _values = await SettingsDialogs().editHost(
          context,
          prefill: host,
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
    String apiKey = Database.currentProfileObject.sonarrKey ?? '';
    return LunaBlock(
      title: 'settings.ApiKey'.tr(),
      body: [
        TextSpan(
          text: apiKey.isEmpty
              ? 'lunasea.NotSet'.tr()
              : LunaUI.TEXT_OBFUSCATED_PASSWORD,
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> _values = await LunaDialogs().editText(
          context,
          'settings.ApiKey'.tr(),
          prefill: apiKey,
        );
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
      text: 'settings.TestConnection'.tr(),
      icon: LunaIcons.CONNECTION_TEST,
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
          headers: Map<String, dynamic>.from(
            _profile.sonarrHeaders ?? {},
          ),
        ).system.getStatus().then((_) {
          showLunaSuccessSnackBar(
            title: 'Connected Successfully',
            message: 'Sonarr is ready to use with LunaSea',
          );
        }).catchError((error, trace) {
          LunaLogger().error(
            'Connection Test Failed',
            error,
            trace,
          );
          showLunaErrorSnackBar(
            title: 'Connection Test Failed',
            error: error,
          );
        });
      },
    );
  }

  Widget _customHeaders() {
    return LunaBlock(
      title: 'settings.CustomHeaders'.tr(),
      body: [TextSpan(text: 'settings.CustomHeadersDescription'.tr())],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => SettingsConfigurationSonarrHeadersRouter().navigateTo(
        context,
      ),
    );
  }
}
