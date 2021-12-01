import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsAccountSettingsRouter extends SettingsPageRouter {
  SettingsAccountSettingsRouter() : super('/settings/account/settings');

  @override
  _SettingsAccountSettingsRoute widget() => _SettingsAccountSettingsRoute();

  @override
  void defineRoute(FluroRouter router) {
    super.noParameterRouteDefinition(router);
  }
}

class _SettingsAccountSettingsRoute extends StatefulWidget {
  @override
  State<_SettingsAccountSettingsRoute> createState() => _State();
}

class _State extends State<_SettingsAccountSettingsRoute>
    with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'settings.AccountSettings'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: const [
        SettingsAccountDeleteAccountTile(),
      ],
    );
  }
}
