import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesQuickActionsTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Quick Actions'),
        subtitle: LSSubtitle(text: 'Enable Quick Actions on the Home Screen'),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => _onTap(context),
    );

    Future<void> _onTap(BuildContext context) async => Navigator.of(context).pushNamed(SettingsModulesLunaSeaQuickActions.ROUTE_NAME);
}
