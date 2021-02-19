import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sabnzbd.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationSABnzbdRouter extends LunaPageRouter {
    SettingsConfigurationSABnzbdRouter() : super('/settings/configuration/sabnzbd');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationSABnzbdRoute());
}

class _SettingsConfigurationSABnzbdRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationSABnzbdRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationSABnzbdRoute> {
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
            title: 'SABnzbd',
            actions: [
                LunaIconButton(
                    icon: Icons.help_outline,
                    onPressed: () async => SettingsDialogs.moduleInformation(context, LunaModule.SABNZBD),
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
                title: LunaText.title(text: 'Enable ${LunaModule.SABNZBD.name}'),
                trailing: LunaSwitch(
                    value: Database.currentProfileObject.sabnzbdEnabled ?? false,
                    onChanged: (value) {
                        Database.currentProfileObject.sabnzbdEnabled = value;
                        Database.currentProfileObject.save();
                        context.read<SABnzbdState>().reset();
                    },
                ),
            ),
        );
    }

    Widget _connectionDetailsPage() {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Connection Details'),
            subtitle: LunaText.subtitle(text: 'Connection Details for SABnzbd'),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async => SettingsConfigurationSABnzbdConnectionDetailsRouter().navigateTo(context),
        );
    }

    // Widget _defaultPagesPage() {
    //     return LunaListTile(
    //         context: context,
    //         title: LunaText.title(text: 'Default Pages'),
    //         subtitle: LunaText.subtitle(text: 'Set Default Landing Pages'),
    //         trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
    //         onTap: () async => SettingsConfigurationSABnzbdDefaultPagesRouter().navigateTo(context),
    //     );
    // }

    Widget _homePage() {
        return SABnzbdDatabaseValue.NAVIGATION_INDEX.listen(
            builder: (context, box, _) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Default Page'),
                subtitle: LunaText.subtitle(text: SABnzbdNavigationBar.titles[SABnzbdDatabaseValue.NAVIGATION_INDEX.data]),
                trailing: LunaIconButton(icon: SABnzbdNavigationBar.icons[SABnzbdDatabaseValue.NAVIGATION_INDEX.data]),
                onTap: () async {
                    List values = await SABnzbdDialogs.defaultPage(context);
                    if(values[0]) SABnzbdDatabaseValue.NAVIGATION_INDEX.put(values[1]);
                },
            ),
        );
    }
}
