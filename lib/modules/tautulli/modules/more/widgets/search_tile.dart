import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliMoreSearchTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Search'),
        subtitle: LSSubtitle(text: 'Search Your Libraries'),
        trailing: LSIconButton(
            icon: Icons.search,
            color: LSColors.list(5),
        ),
        onTap: () async => _onTap(context),
    );

    Future<void> _onTap(BuildContext context) async => TautulliSearchRouter.navigateTo(context: context);
}
