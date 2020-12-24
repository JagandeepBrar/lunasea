import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsAccountSignedInBody extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SettingsAccountSignedInBody> {
    @override
    Widget build(BuildContext context) => LSListView(children: [
        LSCardTile(
            title: LSTitle(text: 'Backup to Cloud'),
            subtitle: LSSubtitle(text: 'Backup Configuration Data'),
            trailing: LSIconButton(icon: Icons.cloud_upload_rounded),
            onTap: () async => {},
        ),
        LSCardTile(
            title: LSTitle(text: 'Restore from Cloud'),
            subtitle: LSSubtitle(text: 'Restore Configuration Data'),
            trailing: LSIconButton(icon: Icons.cloud_download_rounded),
            onTap: () async => {},
        ),
    ]);
}
