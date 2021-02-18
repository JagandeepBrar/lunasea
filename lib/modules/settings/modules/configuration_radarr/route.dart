import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationRadarrRouter extends LunaPageRouter {
    SettingsConfigurationRadarrRouter() : super('/settings/configuration/radarr');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationRadarrRoute());
}

class _SettingsConfigurationRadarrRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationRadarrRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationRadarrRoute> {
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
            title: 'Radarr',
            state: context.read<SettingsState>(),
            actions: [
                LunaIconButton(
                    icon: Icons.help_outline,
                    onPressed: () async => SettingsDialogs.moduleInformation(context, RadarrConstants.MODULE_METADATA),
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
                _discoverUseRadarrSuggestionsToggle(),
            ],
        );
    }

    Widget _enabledToggle() {
        return ValueListenableBuilder(
            valueListenable: Database.profilesBox.listenable(),
            builder: (context, _, __) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Enable ${LunaModule.RADARR.name}'),
                trailing: LunaSwitch(
                    value: Database.currentProfileObject.radarrEnabled ?? false,
                    onChanged: (value) {
                        Database.currentProfileObject.radarrEnabled = value;
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
            subtitle: LunaText.subtitle(text: 'Connection Details for Radarr'),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async => SettingsConfigurationRadarrConnectionDetailsRouter().navigateTo(context),
        );
    }

    Widget _defaultPagesPage() {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Default Pages'),
            subtitle: LunaText.subtitle(text: 'Set Default Landing Pages'),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async => SettingsConfigurationRadarrDefaultPagesRouter().navigateTo(context),
        );
    }

    Widget _defaultSortingFilteringPage() {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Default Sorting & Filtering'),
            subtitle: LunaText.subtitle(text: 'Set Default Sorting & Filtering Methods'),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async => SettingsConfigurationRadarrDefaultSortingRouter().navigateTo(context),
        );
    }

    Widget _discoverUseRadarrSuggestionsToggle() {
        return RadarrDatabaseValue.ADD_DISCOVER_USE_SUGGESTIONS.listen(
            builder: (context, _, __) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Discover Suggestions'),
                subtitle: LunaText.subtitle(text: 'Add Suggested Releases in Discover'),
                trailing: LunaSwitch(
                    value: RadarrDatabaseValue.ADD_DISCOVER_USE_SUGGESTIONS.data,
                    onChanged: (value) => RadarrDatabaseValue.ADD_DISCOVER_USE_SUGGESTIONS.put(value),
                ),
            ),
        );
    }
}
