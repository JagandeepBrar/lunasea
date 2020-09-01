import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsModulesSABnzbdCustomHeadersTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Custom Headers'),
        subtitle: LSSubtitle(text: 'Add Custom Headers to Requests'),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => Navigator.of(context).pushNamed(''),
    );
}
