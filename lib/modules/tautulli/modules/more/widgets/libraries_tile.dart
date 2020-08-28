import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class TautulliMoreLibrariesTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Libraries'),
        subtitle: LSSubtitle(text: 'Your Plex Library Metadata'),
        trailing: LSIconButton(
            icon: Icons.video_library,
            color: LSColors.list(1),
        ),
        onTap: () async => _onTap(context),
    );

    Future<void> _onTap(BuildContext context) async => LSSnackBar(
        context: context,
        title: 'Coming Soon!',
        message: 'This feature has not yet been implemented',
        type: SNACKBAR_TYPE.info,
    );
}
