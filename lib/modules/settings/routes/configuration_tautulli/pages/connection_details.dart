import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/modules/tautulli.dart';

class SettingsConfigurationTautulliConnectionDetailsRouter
    extends SettingsPageRouter {
  SettingsConfigurationTautulliConnectionDetailsRouter()
      : super('/settings/configuration/tautulli/connection');

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
    String host = Database.currentProfileObject.tautulliHost ?? '';
    return LunaBlock(
      title: 'settings.Host'.tr(),
      body: [TextSpan(text: host.isEmpty ? 'lunasea.NotSet'.tr() : host)],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> _values = await SettingsDialogs().editHost(
          context,
          prefill: Database.currentProfileObject.tautulliHost ?? '',
        );
        if (_values.item1) {
          Database.currentProfileObject.tautulliHost = _values.item2;
          Database.currentProfileObject.save();
          context.read<TautulliState>().reset();
        }
      },
    );
  }

  Widget _apiKey() {
    String apiKey = Database.currentProfileObject.tautulliKey ?? '';
    return LunaBlock(
      title: 'settings.ApiKey'.tr(),
      body: [
        TextSpan(
          text: apiKey.isEmpty
              ? 'lunasea.NotSet'.tr()
              : LunaUI.TEXT_BULLET.repeat(12),
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> _values = await LunaDialogs().editText(
          context,
          'settings.ApiKey'.tr(),
          prefill: Database.currentProfileObject.tautulliKey ?? '',
        );
        if (_values.item1) {
          Database.currentProfileObject.tautulliKey = _values.item2;
          Database.currentProfileObject.save();
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
        ProfileHiveObject _profile = Database.currentProfileObject;
        if (_profile?.tautulliHost?.isEmpty ?? true) {
          showLunaErrorSnackBar(
            title: 'Host Required',
            message: 'Host is required to connect to Tautulli',
          );
          return;
        }
        if (_profile?.tautulliKey?.isEmpty ?? true) {
          showLunaErrorSnackBar(
            title: 'API Key Required',
            message: 'API key is required to connect to Tautulli',
          );
          return;
        }
        Tautulli(
                host: _profile.tautulliHost,
                apiKey: _profile.tautulliKey,
                headers:
                    Map<String, dynamic>.from(_profile?.tautulliHeaders ?? {}))
            .miscellaneous
            .arnold()
            .then((_) => showLunaSuccessSnackBar(
                  title: 'Connected Successfully',
                  message: 'Tautulli is ready to use with LunaSea',
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
    return LunaBlock(
      title: 'settings.CustomHeaders'.tr(),
      body: [TextSpan(text: 'settings.CustomHeadersDescription'.tr())],
      trailing: const LunaIconButton.arrow(),
      onTap: () async =>
          SettingsConfigurationTautulliHeadersRouter().navigateTo(context),
    );
  }
}
