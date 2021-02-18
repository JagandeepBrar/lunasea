import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationLidarrRouter extends LunaPageRouter {
    SettingsConfigurationLidarrRouter() : super('/settings/configuration/lidarr');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationLidarrRoute());
}

class _SettingsConfigurationLidarrRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationLidarrRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationLidarrRoute> {
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
            title: 'Lidarr',
            state: context.read<SettingsState>(),
            actions: [
                LunaIconButton(
                    icon: Icons.help_outline,
                    onPressed: () async => SettingsDialogs.moduleInformation(context, LidarrConstants.MODULE_METADATA),
                ),
            ],
        );
    }

    Widget _body() {
        return LunaListView(
            scrollController: context.read<SettingsState>().scrollController,
            children: [
                _enabledToggle(),
                _connectionDetailsPage(),
                LunaDivider(),
                _defaultPagesPage(),
            ],
        );
    }

    Widget _enabledToggle() {
        return ValueListenableBuilder(
            valueListenable: Database.profilesBox.listenable(),
            builder: (context, _, __) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Enable ${LunaModule.LIDARR.name}'),
                trailing: LunaSwitch(
                    value: Database.currentProfileObject.lidarrEnabled ?? false,
                    onChanged: (value) {
                        Database.currentProfileObject.lidarrEnabled = value;
                        Database.currentProfileObject.save();
                    },
                ),
            ),
        );
    }

    Widget _connectionDetailsPage() {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Connection Details'),
            subtitle: LunaText.subtitle(text: 'Connection Details for Lidarr'),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async => SettingsConfigurationLidarrConnectionDetailsRouter().navigateTo(context),
        );
    }

    Widget _defaultPagesPage() {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Default Pages'),
            subtitle: LunaText.subtitle(text: 'Set Default Landing Pages'),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async => SettingsConfigurationLidarrDefaultPagesRouter().navigateTo(context),
        );
    }
}
