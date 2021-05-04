import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationExternalModulesRouter extends SettingsPageRouter {
  SettingsConfigurationExternalModulesRouter()
      : super('/settings/configuration/externalmodules');

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
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      scrollControllers: [scrollController],
      title: LunaModule.EXTERNAL_MODULES.name,
      actions: [
        LunaIconButton(
          icon: Icons.help_outline,
          onPressed: () async {
            SettingsDialogs()
                .moduleInformation(context, LunaModule.EXTERNAL_MODULES);
          },
        ),
      ],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [],
    );
  }
}
