import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationLidarrHeadersRouter extends SettingsPageRouter {
  SettingsConfigurationLidarrHeadersRouter()
      : super('/settings/configuration/lidarr/headers');

  @override
  Widget widget() => const SettingsHeaderRoute(module: LunaModule.LIDARR);

  @override
  void defineRoute(FluroRouter router) {
    super.noParameterRouteDefinition(router);
  }
}
