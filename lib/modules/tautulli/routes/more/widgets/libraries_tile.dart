import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliMoreLibrariesTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Libraries'),
        subtitle: LSSubtitle(text: 'Plex Library Information'),
        trailing: LSIconButton(
            icon: Icons.video_library,
            color: LunaColours.list(2),
        ),
        onTap: () async => _onTap(context),
    );

    Future<void> _onTap(BuildContext context) async => TautulliLibrariesRouter.navigateTo(context);
}
