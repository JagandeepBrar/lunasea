import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsHomeRouter extends LunaPageRouter {
    static const ROUTE_NAME = '/settings';

    Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        ROUTE_NAME,
    );

    String route(List parameters) => ROUTE_NAME;
    
    void defineRoutes(FluroRouter router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => _Widget()),
        transitionType: LunaRouter.transitionType,
    );
}

class _Widget extends StatefulWidget {
    @override
    State<_Widget> createState() => _State();
}

class _State extends State<_Widget> {
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
        hideLeading: true,
        title: SettingsConstants.MODULE_MAP.name,
    );

    Widget get _body => LSListView(
        children: [
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
                onTap: () async => SettingsProfilesRouter().navigateTo(context),
            ),
            LSDivider(),
            LSCardTile(
                title: LSTitle(text: 'Backup & Restore'),
                subtitle: LSSubtitle(text: 'Backup & Restore Your Configuration'),
                trailing: LSIconButton(icon: Icons.settings_backup_restore),
                onTap: () async => SettingsBackupRestoreRouter().navigateTo(context),
            ),
            LSCardTile(
                title: LSTitle(text: 'Donations'),
                subtitle: LSSubtitle(text: 'Donate to the Developer'),
                trailing: LSIconButton(icon: Icons.attach_money),
                onTap: () async => SettingsDonationsRouter().navigateTo(context),
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
                onTap: () async => SettingsSystemRouter().navigateTo(context),
            ),
        ],
    );
}
