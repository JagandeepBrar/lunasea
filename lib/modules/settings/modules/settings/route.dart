import 'package:flutter/material.dart' hide Router;
import 'package:fluro_fork/fluro_fork.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsHomeRouter {
    static const ROUTE_NAME = '/settings';

    static Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;
    
    static void defineRoutes(Router router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => _SettingsRoute()),
        transitionType: LunaRouter.transitionType,
    );

    SettingsHomeRouter._();
}

class _SettingsRoute extends StatefulWidget {
    @override
    State<_SettingsRoute> createState() => _State();
}

class _State extends State<_SettingsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            key: _scaffoldKey,
            appBar: _appBar,
            drawer: _drawer,
            body: _body,
        ),
    );

    Future<bool> _onWillPop() async {
        if(_scaffoldKey.currentState.isDrawerOpen) return true;
        _scaffoldKey.currentState.openDrawer();
        return false;
    }

    Widget get _drawer => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [LunaSeaDatabaseValue.DRAWER_GROUP_MODULES.key]),
        builder: (context, box, _) => LSDrawer(page: SettingsConstants.MODULE_KEY),
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        popUntil: null,
        hideLeading: true,
        title: SettingsConstants.MODULE_MAP.name,
    );

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
            onTap: () async => SettingsCustomizationRouter.navigateTo(context),
        ),
        LSCardTile(
            title: LSTitle(text: 'Modules'),
            subtitle: LSSubtitle(text: 'Configure & Setup Modules'),
            trailing: LSIconButton(icon: Icons.device_hub),
            onTap: () async => SettingsModulesRouter.navigateTo(context),
        ),
        LSCardTile(
            title: LSTitle(text: 'Profiles'),
            subtitle: LSSubtitle(text: 'Manage Your Profiles'),
            trailing: LSIconButton(icon: Icons.person),
            onTap: () async => SettingsProfilesRouter.navigateTo(context),
        ),
    ];

    List<Widget> get _trailing => [
        LSCardTile(
            title: LSTitle(text: 'Backup & Restore'),
            subtitle: LSSubtitle(text: 'Backup & Restore Your Configuration'),
            trailing: LSIconButton(icon: Icons.settings_backup_restore),
            onTap: () async => SettingsBackupRestoreRouter.navigateTo(context),
        ),
        LSCardTile(
            title: LSTitle(text: 'Donations'),
            subtitle: LSSubtitle(text: 'Donate to the Developer'),
            trailing: LSIconButton(icon: Icons.attach_money),
            onTap: () async => SettingsDonationsRouter.navigateTo(context),
        ),
        LSCardTile(
            title: LSTitle(text: 'Logs'),
            subtitle: LSSubtitle(text: 'View, Export, & Clear Logs'),
            trailing: LSIconButton(icon: Icons.developer_mode),
            onTap: () async => SettingsLogsRouter.navigateTo(context),
        ),
        LSCardTile(
            title: LSTitle(text: 'Resources'),
            subtitle: LSSubtitle(text: 'Useful Resources & Links'),
            trailing: LSIconButton(icon: Icons.help_outline),
            onTap: () async => SettingsResourcesRouter.navigateTo(context),
        ),
        LSCardTile(
            title: LSTitle(text: 'System'),
            subtitle: LSSubtitle(text: 'System Utilities & Information'),
            trailing: LSIconButton(icon: Icons.settings),
            onTap: () async => SettingsSystemRouter.navigateTo(context),
        ),
    ];
}
