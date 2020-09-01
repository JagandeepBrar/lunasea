import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsSystemLicensesTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Licenses'),
        subtitle: LSSubtitle(text: 'License Attributions'),
        trailing: LSIconButton(icon: Icons.description),
        onTap: () async => Constants.URL_LICENSES.lsLinks_OpenLink(),
    );
}
