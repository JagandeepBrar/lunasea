import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsHomeRouter extends LunaPageRouter {
    SettingsHomeRouter() : super('/settings');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsHomeRoute());
}

class _SettingsHomeRoute extends StatefulWidget {
    @override
    State<_SettingsHomeRoute> createState() => _State();
}

class _State extends State<_SettingsHomeRoute> {
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
        valueListenable: Database.lunaSeaBox.listenable(keys: [LunaDatabaseValue.DRAWER_GROUP_MODULES.key]),
        builder: (context, box, _) => LSDrawer(page: SettingsConstants.MODULE_KEY),
    );

    Widget get _appBar => LunaAppBar(
        useDrawer: true,
        title: SettingsConstants.MODULE_METADATA.name,
    );

    Widget get _body => LSListView(
        children: [
            LSCardTile(
                title: LSTitle(text: 'Account'),
                subtitle: LSSubtitle(text: 'Your ${Constants.APPLICATION_NAME} Account'),
                trailing: LSIconButton(icon: Icons.account_circle),
                onTap: () async => SettingsAccountRouter().navigateTo(context),
            ),
            LSCardTile(
                title: LSTitle(text: 'Configuration'),
                subtitle: LSSubtitle(text: 'Configure & Setup ${Constants.APPLICATION_NAME}'),
                trailing: LSIconButton(icon: Icons.device_hub),
                onTap: () async => SettingsConfigurationRouter().navigateTo(context),
            ),
            LSCardTile(
                title: LSTitle(text: 'Profiles'),
                subtitle: LSSubtitle(text: 'Manage Your Profiles'),
                trailing: LSIconButton(icon: Icons.person),
                onTap: () async => SettingsProfilesRouter().navigateTo(context),
            ),
            LSDivider(),
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
                onTap: () async => SettingsResourcesRouter().navigateTo(context),
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
