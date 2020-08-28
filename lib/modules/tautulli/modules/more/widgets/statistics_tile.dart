import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class TautulliMoreStatisticsTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Statistics'),
        subtitle: LSSubtitle(text: 'User & Library Statistics'),
        trailing: LSIconButton(
            icon: Icons.format_list_numbered,
            color: LSColors.list(4),
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
