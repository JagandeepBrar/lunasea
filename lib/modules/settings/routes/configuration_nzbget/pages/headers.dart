import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationNZBGetHeadersRouter extends SettingsPageRouter {
  SettingsConfigurationNZBGetHeadersRouter()
      : super('/settings/configuration/nzbget/headers');

  @override
  Widget widget() => const SettingsHeaderRoute(module: LunaModule.NZBGET);

  @override
  void defineRoute(FluroRouter router) {
    super.noParameterRouteDefinition(router);
  }
}
