import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/nzbget.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationNZBGetConnectionDetailsRouter
    extends SettingsPageRouter {
  SettingsConfigurationNZBGetConnectionDetailsRouter()
      : super('/settings/configuration/nzbget/connection');

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
      appBar: _appBar() as PreferredSizeWidget?,
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
      valueListenable: Database.profiles.box.listenable(),
      builder: (context, dynamic box, _) => LunaListView(
        controller: scrollController,
        children: [
          _host(),
          _username(),
          _password(),
          _customHeaders(),
        ],
      ),
    );
  }

  Widget _host() {
    String host = LunaProfile.current.nzbgetHost ?? '';
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
          LunaProfile.current.nzbgetHost = _values.item2;
          LunaProfile.current.save();
          context.read<NZBGetState>().reset();
        }
      },
    );
  }

  Widget _username() {
    String username = LunaProfile.current.nzbgetUser ?? '';
    return LunaBlock(
      title: 'settings.Username'.tr(),
      body: [
        TextSpan(text: username.isEmpty ? 'lunasea.NotSet'.tr() : username),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> _values = await LunaDialogs().editText(
          context,
          'settings.Username'.tr(),
          prefill: username,
        );
        if (_values.item1) {
          LunaProfile.current.nzbgetUser = _values.item2;
          LunaProfile.current.save();
          context.read<NZBGetState>().reset();
        }
      },
    );
  }

  Widget _password() {
    String password = LunaProfile.current.nzbgetPass ?? '';
    return LunaBlock(
      title: 'settings.Password'.tr(),
      body: [
        TextSpan(
          text: password.isEmpty
              ? 'lunasea.NotSet'.tr()
              : LunaUI.TEXT_OBFUSCATED_PASSWORD,
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> _values = await LunaDialogs().editText(
          context,
          'settings.Password'.tr(),
          prefill: password,
          extraText: [
            LunaDialog.textSpanContent(
              text:
                  '${LunaUI.TEXT_BULLET}\tIf your password includes special characters, considering adding a ',
            ),
            LunaDialog.bolded(text: 'basic authentication'),
            LunaDialog.textSpanContent(
                text:
                    ' header with your username and password instead for better support'),
          ],
        );
        if (_values.item1) {
          LunaProfile.current.nzbgetPass = _values.item2;
          LunaProfile.current.save();
          context.read<NZBGetState>().reset();
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
        if (_profile.nzbgetHost == null || _profile.nzbgetHost!.isEmpty) {
          showLunaErrorSnackBar(
            title: 'Host Required',
            message: 'Host is required to connect to NZBGet',
          );
          return;
        }
        NZBGetAPI.from(LunaProfile.current)
            .testConnection()
            .then((_) => showLunaSuccessSnackBar(
                  title: 'Connected Successfully',
                  message: 'NZBGet is ready to use with LunaSea',
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
      onTap: () async {
        SettingsConfigurationNZBGetHeadersRouter().navigateTo(context);
      },
    );
  }
}
