import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationLidarrConnectionDetailsRouter
    extends SettingsPageRouter {
  SettingsConfigurationLidarrConnectionDetailsRouter()
      : super('/settings/configuration/lidarr/connection');

  @override
  _Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) {
    super.noParameterRouteDefinition(router);
  }
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
      title: 'settings.ConnectionDetails'.tr(),
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
    String host = Database.currentProfileObject.lidarrHost ?? '';
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
          Database.currentProfileObject.lidarrHost = _values.item2;
          Database.currentProfileObject.save();
          context.read<LidarrState>().reset();
        }
      },
    );
  }

  Widget _apiKey() {
    String apiKey = Database.currentProfileObject.lidarrKey ?? '';
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
          Database.currentProfileObject.lidarrKey = _values.item2;
          Database.currentProfileObject.save();
          context.read<LidarrState>().reset();
        }
      },
    );
  }

  Widget _testConnection() {
    return LunaButton.text(
      text: 'settings.TestConnection'.tr(),
      icon: Icons.wifi_tethering_rounded,
      onTap: () async {
        ProfileHiveObject _profile = Database.currentProfileObject;
        if (_profile.lidarrHost == null || _profile.lidarrHost.isEmpty) {
          showLunaErrorSnackBar(
            title: 'settings.HostRequired'.tr(),
            message: 'settings.HostRequiredMessage'.tr(
              args: [LunaModule.LIDARR.name],
            ),
          );
          return;
        }
        if (_profile.lidarrKey == null || _profile.lidarrKey.isEmpty) {
          showLunaErrorSnackBar(
            title: 'settings.ApiKeyRequired'.tr(),
            message: 'settings.ApiKeyRequiredMessage'.tr(
              args: [LunaModule.LIDARR.name],
            ),
          );
          return;
        }
        LidarrAPI.from(Database.currentProfileObject)
            .testConnection()
            .then(
              (_) => showLunaSuccessSnackBar(
                title: 'settings.ConnectedSuccessfully'.tr(),
                message: 'settings.ConnectedSuccessfullyMessage'.tr(
                  args: [LunaModule.LIDARR.name],
                ),
              ),
            )
            .catchError((error, trace) {
          LunaLogger().error(
            'Connection Test Failed',
            error,
            trace,
          );
          showLunaErrorSnackBar(
            title: 'settings.ConnectionTestFailed'.tr(),
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
      onTap: () async {
        SettingsConfigurationLidarrHeadersRouter().navigateTo(context);
      },
    );
  }
}
