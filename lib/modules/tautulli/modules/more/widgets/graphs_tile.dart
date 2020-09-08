import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliMoreGraphsTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Graphs'),
        subtitle: LSSubtitle(text: 'Play Count & Duration Graphs'),
        trailing: LSIconButton(
            icon: Icons.insert_chart,
            color: LSColors.list(0),
        ),
        onTap: () async => _onTap(context),
    );

    Future<void> _onTap(BuildContext context) async => TautulliRouter.router.navigateTo(
        context,
        TautulliGraphsRoute.route(),
    );
}
