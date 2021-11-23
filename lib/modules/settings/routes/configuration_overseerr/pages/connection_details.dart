import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/overseerr.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationOverseerrConnectionDetailsRouter
    extends SettingsPageRouter {
  SettingsConfigurationOverseerrConnectionDetailsRouter()
      : super('/settings/configuration/overseerr/connection');

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
    String host = Database.currentProfileObject.overseerrHost;
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'Host'),
      subtitle: LunaText.subtitle(
        text: (host ?? '').isEmpty ? 'Not Set' : host,
      ),
      trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
      onTap: () async {
        Tuple2<bool, String> _values = await SettingsDialogs().editHost(
          context,
          prefill: Database.currentProfileObject.overseerrHost ?? '',
        );
        if (_values.item1) {
          Database.currentProfileObject.overseerrHost = _values.item2;
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
      subtitle: LunaText.subtitle(
        text: (apiKey ?? '').isEmpty ? 'Not Set' : '••••••••••••',
      ),
      trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
      onTap: () async {
        Tuple2<bool, String> _values = await LunaDialogs().editText(
          context,
          'Overseerr API Key',
          prefill: Database.currentProfileObject.overseerrKey ?? '',
        );
        if (_values.item1) {
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
      onTap: () async {
        ProfileHiveObject _profile = Database.currentProfileObject;
        if (_profile.overseerrHost == null || _profile.overseerrHost.isEmpty) {
          showLunaErrorSnackBar(
            title: 'Host Required',
            message: 'Host is required to connect to Overseerr',
          );
          return;
        }
        if (_profile.overseerrKey == null || _profile.overseerrKey.isEmpty) {
          showLunaErrorSnackBar(
            title: 'API Key Required',
            message: 'API key is required to connect to Overseerr',
          );
          return;
        }
        Overseerr(
          host: _profile.overseerrHost,
          apiKey: _profile.overseerrKey,
          headers: Map<String, dynamic>.from(_profile.overseerrHeaders ?? {}),
        )
            .status
            .getStatus()
            .then(
              (_) => showLunaSuccessSnackBar(
                title: 'Connected Successfully',
                message: 'Overseerr is ready to use with LunaSea',
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
              title: 'Connection Test Failed',
              error: error,
            );
          },
        );
      },
    );
  }

  Widget _customHeaders() {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'Custom Headers'),
      subtitle: LunaText.subtitle(text: 'Add Custom Headers to Requests'),
      trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
      onTap: () async {
        SettingsConfigurationOverseerrHeadersRouter().navigateTo(context);
      },
    );
  }
}
