import 'package:flutter/material.dart';
import 'package:lunasea/modules.dart';
import 'package:lunasea/modules/settings.dart';

class ConfigurationNZBGetConnectionDetailsHeadersRoute extends StatelessWidget {
  const ConfigurationNZBGetConnectionDetailsHeadersRoute({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SettingsHeaderRoute(module: LunaModule.NZBGET);
  }
}
