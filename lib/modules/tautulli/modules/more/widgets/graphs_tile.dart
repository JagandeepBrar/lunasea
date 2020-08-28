import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class TautulliMoreGraphsTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Graphs'),
        subtitle: LSSubtitle(text: 'Play Count & Duration Graphs'),
        trailing: LSIconButton(
            icon: Icons.show_chart,
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
