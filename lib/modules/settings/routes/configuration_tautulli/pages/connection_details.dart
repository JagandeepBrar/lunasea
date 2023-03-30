import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:lunasea/router/routes/settings.dart';

class ConfigurationTautulliConnectionDetailsRoute extends StatefulWidget {
  const ConfigurationTautulliConnectionDetailsRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationTautulliConnectionDetailsRoute> createState() => _State();
}

class _State extends State<ConfigurationTautulliConnectionDetailsRoute>
    with LunaScrollControllerMixin {
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

  PreferredSizeWidget _appBar() {
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
    return LunaBox.profiles.listenableBuilder(
      builder: (context, _) => LunaListView(
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
    String host = LunaProfile.current.tautulliHost;
    return LunaBlock(
      title: 'settings.Host'.tr(),
      body: [TextSpan(text: host.isEmpty ? 'lunasea.NotSet'.tr() : host)],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> _values = await SettingsDialogs().editHost(
          context,
          prefill: LunaProfile.current.tautulliHost,
        );
        if (_values.item1) {
          LunaProfile.current.tautulliHost = _values.item2;
          LunaProfile.current.save();
          context.read<TautulliState>().reset();
        }
      },
    );
  }

  Widget _apiKey() {
    String apiKey = LunaProfile.current.tautulliKey;
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
          prefill: LunaProfile.current.tautulliKey,
        );
        if (_values.item1) {
          LunaProfile.current.tautulliKey = _values.item2;
          LunaProfile.current.save();
          context.read<TautulliState>().reset();
        }
      },
    );
  }

  Widget _testConnection() {
    return LunaButton.text(
      text: 'settings.TestConnection'.tr(),
      icon: LunaIcons.CONNECTION_TEST,
      onTap: () async {
        LunaProfile _profile = LunaProfile.current;
        if (_profile.tautulliHost.isEmpty) {
          showLunaErrorSnackBar(
            title: 'settings.HostRequired'.tr(),
            message: 'settings.HostRequiredMessage'
                .tr(args: [LunaModule.TAUTULLI.title]),
          );
          return;
        }
        if (_profile.tautulliKey.isEmpty) {
          showLunaErrorSnackBar(
            title: 'settings.ApiKeyRequired'.tr(),
            message: 'settings.ApiKeyRequiredMessage'
                .tr(args: [LunaModule.TAUTULLI.title]),
          );
          return;
        }
        TautulliAPI(
                host: _profile.tautulliHost,
                apiKey: _profile.tautulliKey,
                headers: Map<String, dynamic>.from(_profile.tautulliHeaders))
            .miscellaneous
            .arnold()
            .then((_) => showLunaSuccessSnackBar(
                  title: 'settings.ConnectedSuccessfully'.tr(),
                  message: 'settings.ConnectedSuccessfullyMessage'
                      .tr(args: [LunaModule.TAUTULLI.title]),
                ))
            .catchError((error, trace) {
          LunaLogger().error('Connection Test Failed', error, trace);
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
      onTap:
          SettingsRoutes.CONFIGURATION_TAUTULLI_CONNECTION_DETAILS_HEADERS.go,
    );
  }
}
