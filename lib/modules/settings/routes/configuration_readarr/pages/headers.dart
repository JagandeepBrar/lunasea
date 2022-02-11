import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationReadarrHeadersRouter extends SettingsPageRouter {
  SettingsConfigurationReadarrHeadersRouter()
      : super('/settings/configuration/readarr/headers');

  @override
  Widget widget() => const SettingsHeaderRoute(module: LunaModule.READARR);

  @override
  void defineRoute(FluroRouter router) =>
      super.noParameterRouteDefinition(router);
}
