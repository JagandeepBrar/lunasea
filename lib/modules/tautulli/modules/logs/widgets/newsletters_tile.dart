import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class TautulliLogsNewslettersTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Newsletters'),
        subtitle: LSSubtitle(text: 'Tautulli Newsletter Logs'),
        leading: LSIconButton(
            icon: Icons.email,
            color: LSColors.list(3),
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
