import 'package:flutter/material.dart';
import 'package:lunasea/modules.dart';
import 'package:lunasea/modules/settings.dart';

class ConfigurationOverseerrConnectionDetailsHeadersRoute
    extends StatelessWidget {
  const ConfigurationOverseerrConnectionDetailsHeadersRoute({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SettingsHeaderRoute(module: LunaModule.OVERSEERR);
  }
}
