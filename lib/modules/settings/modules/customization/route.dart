import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules.dart';

class SettingsCustomizationRouter {
    static const ROUTE_NAME = '/settings/customization';

    static Future<void> navigateTo(BuildContext context, [List parameters]) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;
    
    static void defineRoutes(FluroRouter router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => _SettingsCustomizationRoute()),
        transitionType: LunaRouter.transitionType,
    );

    SettingsCustomizationRouter._();
}

class _SettingsCustomizationRoute extends StatefulWidget {
    @override
    State<_SettingsCustomizationRoute> createState() => _State();
}

class _State extends State<_SettingsCustomizationRoute> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    bool get wantKeepAlive => true;

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar,
            body: _body,
        );
    }

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Customization',
    );

    Widget get _body => LSListView(
        children: [
            ..._modules,
        ],
    );


    List<Widget> get _modules => [
        LSCardTile(
            title: LSTitle(text: 'Sonarr'),
            subtitle: LSSubtitle(text: 'Sonarr Customizations'),
            trailing: LSIconButton(icon: CustomIcons.television),
            onTap: () async => SettingsCustomizationSonarrRouter.navigateTo(context),
        ),
        LSDivider(),
        LSCardTile(
            title: LSTitle(text: 'NZBGet'),
            subtitle: LSSubtitle(text: 'NZBGet Customizations'),
            trailing: LSIconButton(icon: CustomIcons.nzbget),
            onTap: () async => SettingsCustomizationNZBGetRouter.navigateTo(context),
        ),
        LSCardTile(
            title: LSTitle(text: 'SABnzbd'),
            subtitle: LSSubtitle(text: 'SABnzbd Customizations'),
            trailing: LSIconButton(icon: CustomIcons.sabnzbd),
            onTap: () async => SettingsCustomizationSABnzbdRouter.navigateTo(context),
        ),
        LSDivider(),
        LSCardTile(
            title: LSTitle(text: 'Tautulli'),
            subtitle: LSSubtitle(text: 'Tautulli Customizations'),
            trailing: LSIconButton(icon: CustomIcons.tautulli),
            onTap: () async => SettingsCustomizationTautulliRouter.navigateTo(context),
        ),
    ];
}
