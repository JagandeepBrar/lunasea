import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sabnzbd.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationSABnzbdConnectionDetailsRouter
    extends SettingsPageRouter {
  SettingsConfigurationSABnzbdConnectionDetailsRouter()
      : super('/settings/configuration/sabnzbd/connection');

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
    String host = Database.currentProfileObject.sabnzbdHost ?? '';
    return LunaBlock(
      title: 'settings.Host'.tr(),
      body: [TextSpan(text: host.isEmpty ? 'settings.NotSet'.tr() : host)],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> _values = await SettingsDialogs().editHost(
          context,
          prefill: host,
        );
        if (_values.item1) {
          Database.currentProfileObject.sabnzbdHost = _values.item2;
          Database.currentProfileObject.save();
          context.read<SABnzbdState>().reset();
        }
      },
    );
  }

  Widget _apiKey() {
    String apiKey = Database.currentProfileObject.sabnzbdKey ?? '';
    return LunaBlock(
      title: 'settings.ApiKey'.tr(),
      body: [
        TextSpan(
          text: apiKey.isEmpty
              ? 'settings.NotSet'.tr()
              : LunaUI.TEXT_BULLET.repeat(12),
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
          Database.currentProfileObject.sabnzbdKey = _values.item2;
          Database.currentProfileObject.save();
          context.read<SABnzbdState>().reset();
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
        if (_profile.sabnzbdHost == null || _profile.sabnzbdHost.isEmpty) {
          showLunaErrorSnackBar(
            title: 'Host Required',
            message: 'Host is required to connect to SABnzbd',
          );
          return;
        }
        if (_profile.sabnzbdKey == null || _profile.sabnzbdKey.isEmpty) {
          showLunaErrorSnackBar(
            title: 'API Key Required',
            message: 'API key is required to connect to SABnzbd',
          );
          return;
        }
        SABnzbdAPI.from(Database.currentProfileObject)
            .testConnection()
            .then((_) => showLunaSuccessSnackBar(
                  title: 'Connected Successfully',
                  message: 'SABnzbd is ready to use with LunaSea',
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
          SettingsConfigurationSABnzbdHeadersRouter().navigateTo(context),
    );
  }
}
