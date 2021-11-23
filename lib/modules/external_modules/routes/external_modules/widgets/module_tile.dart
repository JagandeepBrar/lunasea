import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class ExternalModulesModuleTile extends StatelessWidget {
  final ExternalModuleHiveObject module;

  const ExternalModulesModuleTile({
    Key key,
    @required this.module,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: module.displayName),
      subtitle: LunaText.subtitle(text: module.host),
      trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
      onTap: () async => module.host.lunaOpenGenericLink(),
    );
  }
}
