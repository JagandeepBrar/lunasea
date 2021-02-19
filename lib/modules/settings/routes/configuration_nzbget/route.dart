import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/nzbget.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationNZBGetRouter extends LunaPageRouter {
    SettingsConfigurationNZBGetRouter() : super('/settings/configuration/nzbget');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationNZBGetRoute());
}

class _SettingsConfigurationNZBGetRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationNZBGetRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationNZBGetRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar(),
            body: _body(),
        );
    }

    Widget _appBar() {
        return LunaAppBar(
            title: LunaModule.NZBGET.name,
            actions: [
                LunaIconButton(
                    icon: Icons.help_outline,
                    onPressed: () async => SettingsDialogs.moduleInformation(context, LunaModule.NZBGET),
                ),
            ],
        );
    }

    Widget _body() {
        return LunaListView(
            children: [
                _enabledToggle(),
                _connectionDetailsPage(),
                LunaDivider(),
                _homePage(),
                //_defaultPagesPage(),
            ],
        );
    }

    Widget _enabledToggle() {
        return ValueListenableBuilder(
            valueListenable: Database.profilesBox.listenable(),
            builder: (context, _, __) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Enable ${LunaModule.NZBGET.name}'),
                trailing: LunaSwitch(
                    value: Database.currentProfileObject.nzbgetEnabled ?? false,
                    onChanged: (value) {
                        Database.currentProfileObject.nzbgetEnabled = value;
                        Database.currentProfileObject.save();
                        context.read<NZBGetState>().reset();
                    },
                ),
            ),
        );
    }

    Widget _connectionDetailsPage() {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Connection Details'),
            subtitle: LunaText.subtitle(text: 'Connection Details for NZBGet'),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async => SettingsConfigurationNZBGetConnectionDetailsRouter().navigateTo(context),
        );
    }

    Widget _homePage() {
        return NZBGetDatabaseValue.NAVIGATION_INDEX.listen(
            builder: (context, box, _) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Default Page'),
                subtitle: LunaText.subtitle(text: NZBGetNavigationBar.titles[NZBGetDatabaseValue.NAVIGATION_INDEX.data]),
                trailing: LunaIconButton(icon: NZBGetNavigationBar.icons[NZBGetDatabaseValue.NAVIGATION_INDEX.data]),
                onTap: () async {
                    List values = await NZBGetDialogs.defaultPage(context);
                    if(values[0]) NZBGetDatabaseValue.NAVIGATION_INDEX.put(values[1]);
                },
            ),
        );
    }

    // Widget _defaultPagesPage() {
    //     return LunaListTile(
    //         context: context,
    //         title: LunaText.title(text: 'Default Pages'),
    //         subtitle: LunaText.subtitle(text: 'Set Default Landing Pages'),
    //         trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
    //         onTap: () async => SettingsConfigurationNZBGetDefaultPagesRouter().navigateTo(context),
    //     );
    // }
}
