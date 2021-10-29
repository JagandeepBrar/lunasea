import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationTautulliHeadersRouter extends SettingsPageRouter {
  SettingsConfigurationTautulliHeadersRouter()
      : super('/settings/configuration/tautulli/headers');

  @override
  Widget widget() => const SettingsHeaderRoute(module: LunaModule.TAUTULLI);

  @override
  void defineRoute(FluroRouter router) =>
      super.noParameterRouteDefinition(router);
}
