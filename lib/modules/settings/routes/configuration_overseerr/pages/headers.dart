import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationOverseerrHeadersRouter extends SettingsPageRouter {
  SettingsConfigurationOverseerrHeadersRouter()
      : super('/settings/configuration/overseerr/headers');

  @override
  Widget widget() => const SettingsHeaderRoute(module: LunaModule.OVERSEERR);

  @override
  void defineRoute(FluroRouter router) {
    super.noParameterRouteDefinition(router);
  }
}
