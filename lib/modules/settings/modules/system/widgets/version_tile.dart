import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:package_info/package_info.dart';

class SettingsSystemVersionTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => FutureBuilder(
        future: PackageInfo.fromPlatform(),
        builder: (context, AsyncSnapshot<PackageInfo> snapshot) => LSCardTile(
            title: LSTitle(
                text: snapshot.hasData
                    ? 'Version: ${snapshot.data.version} (${snapshot.data.buildNumber})'
                    : 'Version: Loading...',
            ),
            subtitle: LSSubtitle(text: 'View Recent Changes'),
            trailing: LSIconButton(icon: Icons.system_update),
            onTap: () async => await Constants.URL_CHANGELOG.lsLinks_OpenLink(),
        ),
    );
}
