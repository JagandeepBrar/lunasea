import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/string_links.dart';

class ExternalModulesModuleTile extends StatelessWidget {
  final ExternalModuleHiveObject? module;

  const ExternalModulesModuleTile({
    Key? key,
    required this.module,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: module!.displayName,
      body: [TextSpan(text: module!.host)],
      trailing: const LunaIconButton.arrow(),
      onTap: module!.host!.openLink,
    );
  }
}
