import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/modules/sonarr.dart';

class SettingsConfigurationSonarrRouter extends LunaPageRouter {
    SettingsConfigurationSonarrRouter() : super('/settings/configuration/sonarr');

    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationSonarrRoute());
}

class _SettingsConfigurationSonarrRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationSonarrRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationSonarrRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Sonarr',
        actions: [_helpMessageButton],
    );
    
    Widget get _helpMessageButton => LSIconButton(
        icon: Icons.help_outline,
        onPressed: () async => SettingsDialogs.helpMessage(
            context,
            title: SonarrConstants.MODULE_METADATA.name,
            message: SonarrConstants.MODULE_METADATA.helpMessage,
            github: SonarrConstants.MODULE_METADATA.github,
            website: SonarrConstants.MODULE_METADATA.website,
        ),
    );

    Widget get _body => ValueListenableBuilder(
        valueListenable: Database.profilesBox.listenable(),
        builder: (context, box, _) => LSListView(
            children: [
                ..._configuration,
                ..._customization,
            ],
        ),
    );

    List<Widget> get _configuration => [
        _enabledTile,
        _hostTile,
        _apiKeyTile,
        _customHeadersTile,
        _enableVersion3Tile,
        _testConnectionTile,
    ];

    Widget get _enabledTile => LSCardTile(
        title: LSTitle(text: 'Enable Sonarr'),
        trailing: LunaSwitch(
            value: Database.currentProfileObject.sonarrEnabled ?? false,
            onChanged: (value) {
                Database.currentProfileObject.sonarrEnabled = value;
                Database.currentProfileObject.save();
                Provider.of<SonarrState>(context, listen: false).reset();
            },
        ),
    );

    Widget get _enableVersion3Tile => LSCardTile(
        title: LSTitle(text: 'Sonarr v3'),
        subtitle: LSSubtitle(text: 'Enable Support for Sonarr v3'),
        trailing: LunaSwitch(
            value: Database.currentProfileObject.sonarrVersion3 ?? false,
            onChanged: (value) {
                Database.currentProfileObject.sonarrVersion3 = value;
                Database.currentProfileObject.save();
                Provider.of<SonarrState>(context, listen: false).reset();
            },
        ),
    );

    Widget get _hostTile => LSCardTile(
        title: LSTitle(text: 'Host'),
        subtitle: LSSubtitle(text: Database.currentProfileObject.sonarrHost == null || Database.currentProfileObject.sonarrHost == '' ? 'Not Set' : Database.currentProfileObject.sonarrHost),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async {
            List<dynamic> _values = await SettingsDialogs.editHost(context, 'Sonarr Host', prefill: Database.currentProfileObject.sonarrHost ?? '');
            if(_values[0]) {
                Database.currentProfileObject.sonarrHost = _values[1];
                Database.currentProfileObject.save();
                Provider.of<SonarrState>(context, listen: false).reset();
            }
        },
    );

    Widget get _apiKeyTile => LSCardTile(
        title: LSTitle(text: 'API Key'),
        subtitle: LSSubtitle(text: Database.currentProfileObject.sonarrKey == null || Database.currentProfileObject.sonarrKey == '' ? 'Not Set' : '••••••••••••'),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async {
            List<dynamic> _values = await LunaDialogs().editText(context, 'Sonarr API Key', prefill: Database.currentProfileObject.sonarrKey ?? '');
            if(_values[0]) {
                Database.currentProfileObject.sonarrKey = _values[1];
                Database.currentProfileObject.save();
                Provider.of<SonarrState>(context, listen: false).reset();
            }
        },
    );

    Widget get _customHeadersTile => LSCardTile(
        title: LSTitle(text: 'Custom Headers'),
        subtitle: LSSubtitle(text: 'Add Custom Headers to Requests'),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => SettingsConfigurationSonarrHeadersRouter().navigateTo(context),
    );

    Widget get _testConnectionTile => LSButton(
        text: 'Test Connection',
        onTap: () async {
            SonarrState state = Provider.of<SonarrState>(context, listen: false);
            if(state.host == null || state.host.isEmpty) {
                showLunaErrorSnackBar(
                    context: context,
                    title: 'Host Required',
                    message: 'Host is required to connect to Sonarr',
                );
                return;
            }
            if(state.apiKey == null || state.apiKey.isEmpty) {
                showLunaErrorSnackBar(
                    context: context,
                    title: 'API Key Required',
                    message: 'API key is required to connect to Sonarr',
                );
                return;
            }
            Sonarr(host: state.host, apiKey: state.apiKey, headers: Map<String, dynamic>.from(state.headers)).system.getStatus()
            .then((_) => showLunaSuccessSnackBar(
                context: context,
                title: 'Connected Successfully',
                message: 'Sonarr is ready to use with ${Constants.APPLICATION_NAME}',
            )).catchError((error, trace) {
                LunaLogger().error('Connection Test Failed', error, trace);
                showLunaErrorSnackBar(
                    context: context,
                    title: 'Connection Test Failed',
                    error: error,
                );
            });
        },
    );

    List<Widget> get _customization => [
        LSHeader(text: 'Default Pages'),
        _defaultPageHomeTile,
        _defaultPageSeriesDetailsTile,
        LSHeader(text: 'Default Sorting & Filtering'),
        _defaultSortingSeriesTile,
        _defaultSortingSeriesDirectionTile,
        _defaultSortingReleasesTile,
        _defaultSortingReleasesDirectionTile,
    ];

    Widget get _defaultPageHomeTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [SonarrDatabaseValue.NAVIGATION_INDEX.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Home'),
            subtitle: LSSubtitle(text: SonarrNavigationBar.titles[SonarrDatabaseValue.NAVIGATION_INDEX.data]),
            trailing: LSIconButton(icon: SonarrNavigationBar.icons[SonarrDatabaseValue.NAVIGATION_INDEX.data]),
            onTap: () async {
                List<dynamic> _values = await SonarrDialogs.setDefaultPage(context, titles: SonarrNavigationBar.titles, icons: SonarrNavigationBar.icons);
                if(_values[0]) SonarrDatabaseValue.NAVIGATION_INDEX.put(_values[1]);
            },
        ),
    );

    Widget get _defaultPageSeriesDetailsTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Series Details'),
            subtitle: LSSubtitle(text: SonarrSeriesDetailsNavigationBar.titles[SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS.data]),
            trailing: LSIconButton(icon: SonarrSeriesDetailsNavigationBar.icons[SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS.data]),
            onTap: () async {
                List<dynamic> _values = await SonarrDialogs.setDefaultPage(context, titles: SonarrSeriesDetailsNavigationBar.titles, icons: SonarrSeriesDetailsNavigationBar.icons);
                if(_values[0]) SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS.put(_values[1]);
            },
        ),
    );

    Widget get _defaultSortingReleasesTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [SonarrDatabaseValue.DEFAULT_SORTING_RELEASES.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Releases Sort Category'),
            subtitle: LSSubtitle(text: (SonarrDatabaseValue.DEFAULT_SORTING_RELEASES.data as SonarrReleasesSorting).readable),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async {
                List<String> _titles = SonarrReleasesSorting.values.map<String>((e) => e.readable).toList();
                List _values = await SonarrDialogs.setDefaultSortingOrFiltering(context, titles: _titles);
                if(_values[0]) {
                    SonarrDatabaseValue.DEFAULT_SORTING_RELEASES.put(SonarrReleasesSorting.values[_values[1]]);
                    context.read<SonarrState>().releasesSortType = SonarrDatabaseValue.DEFAULT_SORTING_RELEASES.data;
                    context.read<SonarrState>().releasesSortAscending = SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING.data;
                }
            },
        ),
    );

    Widget get _defaultSortingReleasesDirectionTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Releases Sort Direction'),
            subtitle: LSSubtitle(text: SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING.data ? 'Ascending' : 'Descending'),
            trailing: LunaSwitch(
                value: SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING.data,
                onChanged: (value) {
                    SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING.put(value);
                    context.read<SonarrState>().releasesSortType = SonarrDatabaseValue.DEFAULT_SORTING_RELEASES.data;
                    context.read<SonarrState>().releasesSortAscending = SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING.data;
                },
            ),
        ),
    );

    Widget get _defaultSortingSeriesTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [SonarrDatabaseValue.DEFAULT_SORTING_SERIES.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Series Sort Category'),
            subtitle: LSSubtitle(text: (SonarrDatabaseValue.DEFAULT_SORTING_SERIES.data as SonarrSeriesSorting).readable),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async {
                List<String> _titles = SonarrSeriesSorting.values.map<String>((e) => e.readable).toList();
                List _values = await SonarrDialogs.setDefaultSortingOrFiltering(context, titles: _titles);
                if(_values[0]) {
                    SonarrDatabaseValue.DEFAULT_SORTING_SERIES.put(SonarrSeriesSorting.values[_values[1]]);
                    context.read<SonarrState>().seriesSortType = SonarrDatabaseValue.DEFAULT_SORTING_SERIES.data;
                    context.read<SonarrState>().seriesSortAscending = SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING.data;
                }
            },
        ),
    );

    Widget get _defaultSortingSeriesDirectionTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Series Sort Direction'),
            subtitle: LSSubtitle(text: SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING.data ? 'Ascending' : 'Descending'),
            trailing: LunaSwitch(
                value: SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING.data,
                onChanged: (value) {
                    SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING.put(value);
                    context.read<SonarrState>().seriesSortType = SonarrDatabaseValue.DEFAULT_SORTING_SERIES.data;
                    context.read<SonarrState>().seriesSortAscending = SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING.data;
                },
            ),
        ),
    );
}
