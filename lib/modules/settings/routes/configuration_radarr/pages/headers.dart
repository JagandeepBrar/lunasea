import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationRadarrHeadersRouter extends SettingsPageRouter {
  SettingsConfigurationRadarrHeadersRouter()
      : super('/settings/configuration/radarr/headers');

  @override
  Widget widget() => const SettingsHeaderRoute(module: LunaModule.RADARR);

  @override
  void defineRoute(FluroRouter router) {
    super.noParameterRouteDefinition(router);
  }
}
