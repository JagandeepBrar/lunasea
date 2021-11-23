import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationSonarrHeadersRouter extends SettingsPageRouter {
  SettingsConfigurationSonarrHeadersRouter()
      : super('/settings/configuration/sonarr/headers');

  @override
  Widget widget() => const SettingsHeaderRoute(module: LunaModule.SONARR);

  @override
  void defineRoute(FluroRouter router) =>
      super.noParameterRouteDefinition(router);
}
