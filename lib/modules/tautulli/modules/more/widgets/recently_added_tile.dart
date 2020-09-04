import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliMoreRecentlyAddedTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Recently Added'),
        subtitle: LSSubtitle(text: 'Recently Added Content to Plex'),
        trailing: LSIconButton(
            icon: Icons.recent_actors,
            color: LSColors.list(3),
        ),
        onTap: () async => _onTap(context),
    );

    Future<void> _onTap(BuildContext context) async => TautulliRouter.router.navigateTo(
        context,
        TautulliRecentlyAddedRoute.route(),
    );
}
