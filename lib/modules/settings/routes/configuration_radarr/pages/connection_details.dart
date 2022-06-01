import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationRadarrConnectionDetailsRouter
    extends SettingsPageRouter {
  SettingsConfigurationRadarrConnectionDetailsRouter()
      : super('/settings/configuration/radarr/connection');

  @override
  Widget widget() => _Widget();

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
      appBar: _appBar() as PreferredSizeWidget?,
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
      valueListenable: LunaBox.profiles.box.listenable(),
      builder: (context, dynamic box, _) => LunaListView(
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
    String host = LunaProfile.current.radarrHost ?? '';
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
          LunaProfile.current.radarrHost = _values.item2;
          LunaProfile.current.save();
          context.read<RadarrState>().reset();
        }
      },
    );
  }

  Widget _apiKey() {
    String apiKey = LunaProfile.current.radarrKey ?? '';
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
          LunaProfile.current.radarrKey = _values.item2;
          LunaProfile.current.save();
          context.read<RadarrState>().reset();
        }
      },
    );
  }

  Widget _testConnection() {
    return LunaButton.text(
      text: 'settings.TestConnection'.tr(),
      icon: LunaIcons.CONNECTION_TEST,
      onTap: () async {
        ProfileHiveObject _profile = LunaProfile.current;
        if (_profile.radarrHost == null || _profile.radarrHost!.isEmpty) {
          showLunaErrorSnackBar(
            title: 'settings.HostRequired'.tr(),
            message: 'settings.HostRequiredMessage'
                .tr(args: [LunaModule.RADARR.title]),
          );
          return;
        }
        if (_profile.radarrKey == null || _profile.radarrKey!.isEmpty) {
          showLunaErrorSnackBar(
            title: 'settings.ApiKeyRequired'.tr(),
            message: 'settings.ApiKeyRequiredMessage'
                .tr(args: [LunaModule.RADARR.title]),
          );
          return;
        }
        Radarr(
          host: _profile.radarrHost!,
          apiKey: _profile.radarrKey!,
          headers: Map<String, dynamic>.from(_profile.radarrHeaders ?? {}),
        )
            .system
            .status()
            .then(
              (_) => showLunaSuccessSnackBar(
                title: 'settings.ConnectedSuccessfully'.tr(),
                message: 'settings.ConnectedSuccessfullyMessage'
                    .tr(args: [LunaModule.RADARR.title]),
              ),
            )
            .catchError(
          (error, trace) {
            LunaLogger().error(
              'Connection Test Failed',
              error,
              trace,
            );
            showLunaErrorSnackBar(
              title: 'settings.ConnectionTestFailed'.tr(),
              error: error,
            );
          },
        );
      },
    );
  }

  Widget _customHeaders() {
    return LunaBlock(
      title: 'settings.CustomHeaders'.tr(),
      body: [TextSpan(text: 'settings.CustomHeadersDescription'.tr())],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        SettingsConfigurationRadarrHeadersRouter().navigateTo(context);
      },
    );
  }
}
