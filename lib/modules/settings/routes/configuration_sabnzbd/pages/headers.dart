import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationSABnzbdHeadersRouter extends SettingsPageRouter {
  SettingsConfigurationSABnzbdHeadersRouter()
      : super('/settings/configuration/sabnzbd/headers');

  @override
  Widget widget() => SettingsHeaderRoute(module: LunaModule.SABNZBD);

  @override
  void defineRoute(FluroRouter router) {
    super.noParameterRouteDefinition(router);
  }
}
