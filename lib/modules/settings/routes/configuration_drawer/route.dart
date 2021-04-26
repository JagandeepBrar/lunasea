import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationDrawerRouter extends SettingsPageRouter {
  SettingsConfigurationDrawerRouter() : super('/settings/configuration/drawer');

  @override
  Widget widget() => _Widget();

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
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      scrollControllers: [scrollController],
      title: 'Drawer',
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        LunaListTile(
          context: context,
          title: LunaText.title(text: 'Automatically Manage'),
          subtitle: LunaText.subtitle(
            text: 'Automatically Determine Drawer Entries',
          ),
          trailing: LunaDatabaseValue.DRAWER_AUTOMATIC_MANAGE.listen(
            builder: (context, _, __) => LunaSwitch(
              value: LunaDatabaseValue.DRAWER_AUTOMATIC_MANAGE.data,
              onChanged: (value) {
                LunaDatabaseValue.DRAWER_AUTOMATIC_MANAGE.put(value);
              },
            ),
          ),
        ),
        ...List.generate(
          LunaModule.DASHBOARD.enabledExternalModules().length,
          (index) => LunaDatabaseValue.DRAWER_AUTOMATIC_MANAGE.listen(
            builder: (context, _, __) => LunaListTile(
              context: context,
              title: LunaText.title(
                text: LunaModule.DASHBOARD.enabledExternalModules()[index].name,
                darken: LunaDatabaseValue.DRAWER_AUTOMATIC_MANAGE.data,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
