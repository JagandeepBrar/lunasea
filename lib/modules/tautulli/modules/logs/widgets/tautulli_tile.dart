import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class TautulliLogsTautulliTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Tautulli'),
        subtitle: LSSubtitle(text: 'Tautulli Logs'),
        leading: LSIconButton(
            icon: CustomIcons.tautulli,
            color: LSColors.list(0),
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
