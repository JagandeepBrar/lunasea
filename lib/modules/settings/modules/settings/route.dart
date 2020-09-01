import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings';

    SettingsRoute({
        Key key,
    }): super(key: key);

    @override
    State<SettingsRoute> createState() => _State();
}

class _State extends State<SettingsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(title: 'Settings');

    Widget get _body => LSListView(
        children: [
            ..._leading,
            LSDivider(),
            ..._trailing,
        ],
    );

    List<Widget> get _leading => [
        LSCardTile(
            title: LSTitle(text: 'Customization'),
            subtitle: LSSubtitle(text: 'Customize LunaSea & Modules'),
            trailing: LSIconButton(icon: Icons.brush),
            onTap: () async => Navigator.of(context).pushNamed(SettingsCustomizationRoute.ROUTE_NAME),
        ),
        LSCardTile(
            title: LSTitle(text: 'Modules'),
            subtitle: LSSubtitle(text: 'Configure & Setup Modules'),
            trailing: LSIconButton(icon: Icons.device_hub),
            onTap: () async => Navigator.of(context).pushNamed(SettingsModulesRoute.ROUTE_NAME),
        ),
        LSCardTile(
            title: LSTitle(text: 'Profiles'),
            subtitle: LSSubtitle(text: 'Manage Your Profiles'),
            trailing: LSIconButton(icon: Icons.person),
            onTap: () async => Navigator.of(context).pushNamed(SettingsProfilesRoute.ROUTE_NAME),
        ),
    ];

    List<Widget> get _trailing => [
        LSCardTile(
            title: LSTitle(text: 'Backup & Restore'),
            subtitle: LSSubtitle(text: 'Backup & Restore Your Configuration'),
            trailing: LSIconButton(icon: Icons.settings_backup_restore),
            onTap: () async => Navigator.of(context).pushNamed(SettingsBackupRestoreRoute.ROUTE_NAME),
        ),
        LSCardTile(
            title: LSTitle(text: 'Donations'),
            subtitle: LSSubtitle(text: 'Donate to the Developer'),
            trailing: LSIconButton(icon: Icons.attach_money),
            onTap: () async => Navigator.of(context).pushNamed(SettingsDonationsRoute.ROUTE_NAME),
        ),
        LSCardTile(
            title: LSTitle(text: 'Logs'),
            subtitle: LSSubtitle(text: 'View, Export, & Clear Logs'),
            trailing: LSIconButton(icon: Icons.developer_mode),
            onTap: () async => Navigator.of(context).pushNamed(SettingsLogsRoute.ROUTE_NAME),
        ),
        LSCardTile(
            title: LSTitle(text: 'Resources'),
            subtitle: LSSubtitle(text: 'Useful Resources & Links'),
            trailing: LSIconButton(icon: Icons.help_outline),
            onTap: () async => Navigator.of(context).pushNamed(SettingsResourcesRoute.ROUTE_NAME),
        ),
        LSCardTile(
            title: LSTitle(text: 'System'),
            subtitle: LSSubtitle(text: 'System Utilities & Information'),
            trailing: LSIconButton(icon: Icons.settings),
            onTap: () async => Navigator.of(context).pushNamed(SettingsSystemRoute.ROUTE_NAME),
        ),
    ];
}
