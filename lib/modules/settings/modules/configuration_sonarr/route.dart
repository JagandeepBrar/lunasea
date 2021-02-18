import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationSonarrRouter extends LunaPageRouter {
    SettingsConfigurationSonarrRouter() : super('/settings/configuration/sonarr');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationSonarrRoute());
}

class _SettingsConfigurationSonarrRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationSonarrRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationSonarrRoute> {
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
            title: 'Sonarr',
            state: context.read<SettingsState>(),
            actions: [
                LunaIconButton(
                    icon: Icons.help_outline,
                    onPressed: () async => SettingsDialogs.moduleInformation(context, SonarrConstants.MODULE_METADATA),
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
                _defaultSortingFilteringPage(),
            ],
        );
    }

    Widget _enabledToggle() {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Enable Sonarr'),
            trailing: LunaSwitch(
                value: Database.currentProfileObject.sonarrEnabled ?? false,
                onChanged: (value) {
                    Database.currentProfileObject.sonarrEnabled = value;
                    Database.currentProfileObject.save();
                    Provider.of<SonarrState>(context, listen: false).reset();
                },
            ),
        );
    }

    Widget _connectionDetailsPage() {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Connection Details'),
            subtitle: LunaText.subtitle(text: 'Connection Details for Sonarr'),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async => SettingsConfigurationSonarrConnectionDetailsRouter().navigateTo(context),
        );
    }

    Widget _defaultPagesPage() {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Default Pages'),
            subtitle: LunaText.subtitle(text: 'Set Default Landing Pages'),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async => SettingsConfigurationSonarrDefaultPagesRouter().navigateTo(context),
        );
    }

    Widget _defaultSortingFilteringPage() {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Default Sorting & Filtering'),
            subtitle: LunaText.subtitle(text: 'Set Default Sorting & Filtering Methods'),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async => SettingsConfigurationSonarrDefaultSortingRouter().navigateTo(context),
        );
    }
}
