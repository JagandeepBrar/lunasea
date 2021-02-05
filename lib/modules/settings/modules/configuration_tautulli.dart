import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/modules/tautulli.dart';

class SettingsConfigurationTautulliRouter extends LunaPageRouter {
    SettingsConfigurationTautulliRouter() : super('/settings/configuration/tautulli');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationTautulliRoute());
}

class _SettingsConfigurationTautulliRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationTautulliRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationTautulliRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Tautulli',
        actions: [_helpMessageButton],
    );
    
    Widget get _helpMessageButton => LSIconButton(
        icon: Icons.help_outline,
        onPressed: () async => SettingsDialogs.helpMessage(
            context,
            title: TautulliConstants.MODULE_METADATA.name,
            message: TautulliConstants.MODULE_METADATA.helpMessage,
            github: TautulliConstants.MODULE_METADATA.github,
            website: TautulliConstants.MODULE_METADATA.website,
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
        _testConnectionTile,
    ];

    Widget get _enabledTile => LSCardTile(
        title: LSTitle(text: 'Enable Tautulli'),
        trailing: LunaSwitch(
            value: Database.currentProfileObject.tautulliEnabled ?? false,
            onChanged: (value) {
                Database.currentProfileObject.tautulliEnabled = value;
                Database.currentProfileObject.save();
                Provider.of<TautulliState>(context, listen: false).reset();
            },
        ),
    );

    Widget get _hostTile => LSCardTile(
        title: LSTitle(text: 'Host'),
        subtitle: LSSubtitle(text: Database.currentProfileObject.tautulliHost == null || Database.currentProfileObject.tautulliHost == '' ? 'Not Set' : Database.currentProfileObject.tautulliHost),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async {
            List<dynamic> _values = await SettingsDialogs.editHost(context, 'Tautulli Host', prefill: Database.currentProfileObject.tautulliHost ?? '');
            if(_values[0]) {
                Database.currentProfileObject.tautulliHost = _values[1];
                Database.currentProfileObject.save();
                Provider.of<TautulliState>(context, listen: false).reset();
            }
        },
    );

    Widget get _apiKeyTile => LSCardTile(
        title: LSTitle(text: 'API Key'),
        subtitle: LSSubtitle(text: Database.currentProfileObject.tautulliKey == null || Database.currentProfileObject.tautulliKey == '' ? 'Not Set' : '••••••••••••'),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async {
            List<dynamic> _values = await LunaDialogs().editText(context, 'Tautulli API Key', prefill: Database.currentProfileObject.tautulliKey ?? '');
            if(_values[0]) {
                Database.currentProfileObject.tautulliKey = _values[1];
                Database.currentProfileObject.save();
                Provider.of<TautulliState>(context, listen: false).reset();
            }
        },
    );

    Widget get _customHeadersTile => LSCardTile(
        title: LSTitle(text: 'Custom Headers'),
        subtitle: LSSubtitle(text: 'Add Custom Headers to Requests'),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => SettingsConfigurationTautulliHeadersRouter().navigateTo(context),
    );

    Widget get _testConnectionTile {
        Future<void> _testConnection(BuildContext context) async {
            TautulliState state = Provider.of<TautulliState>(context, listen: false);
            if(state.host == null || state.host.isEmpty) {
                showLunaErrorSnackBar(
                    context: context,
                    title: 'Host Required',
                    message: 'Host is required to connect to Tautulli',
                );
                return;
            }
            if(state.apiKey == null || state.apiKey.isEmpty) {
                showLunaErrorSnackBar(
                    context: context,
                    title: 'API Key Required',
                    message: 'API key is required to connect to Tautulli',
                );
                return;
            }
            Tautulli(host: state.host, apiKey: state.apiKey, headers: Map<String, dynamic>.from(state.headers)).miscellaneous.arnold()
            .then((_) {
                showLunaSuccessSnackBar(
                    context: context,
                    title: 'Connected Successfully',
                    message: 'Tautulli is ready to use with ${Constants.APPLICATION_NAME}',
                );
            }).catchError((error, trace) {
                LunaLogger().error('Connection Test Failed', error, trace);
                showLunaErrorSnackBar(
                    context: context,
                    title: 'Connection Test Failed',
                    error: error,
                );
            });
        }
        return LSButton(
            text: 'Test Connection',
            onTap: () async => _testConnection(context),
        );
    }

    List<Widget> get _customization => [
        LSHeader(text: 'Default Pages'),
        _defaultPageHomeTile,
        _defaultPageGraphsTile,
        _defaultPageLibrariesDetailsTile,
        _defaultPageMediaDetailsTile,
        _defaultPageUserDetailsTile,
        LSHeader(text: 'Activity'),
        _defaultTerminationMessageTile,
        _activityRefreshRateTile,
        LSHeader(text: 'Statistics'),
        _statisticsItemCountTile,
    ];

    Widget get _defaultPageHomeTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [TautulliDatabaseValue.NAVIGATION_INDEX.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Home'),
            subtitle: LSSubtitle(text: TautulliNavigationBar.titles[TautulliDatabaseValue.NAVIGATION_INDEX.data]),
            trailing: LSIconButton(icon: TautulliNavigationBar.icons[TautulliDatabaseValue.NAVIGATION_INDEX.data]),
            onTap: () async {
                List<dynamic> _values = await TautulliDialogs.setDefaultPage(context, titles: TautulliNavigationBar.titles, icons: TautulliNavigationBar.icons);
                if(_values[0]) TautulliDatabaseValue.NAVIGATION_INDEX.put(_values[1]);
            }
        ),
    );

    Widget get _defaultPageGraphsTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [TautulliDatabaseValue.NAVIGATION_INDEX_GRAPHS.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Graphs'),
            subtitle: LSSubtitle(text: TautulliGraphsNavigationBar.titles[TautulliDatabaseValue.NAVIGATION_INDEX_GRAPHS.data]),
            trailing: LSIconButton(icon: TautulliGraphsNavigationBar.icons[TautulliDatabaseValue.NAVIGATION_INDEX_GRAPHS.data]),
            onTap: () async {
                List<dynamic> _values = await TautulliDialogs.setDefaultPage(context, titles: TautulliGraphsNavigationBar.titles, icons: TautulliGraphsNavigationBar.icons);
                if(_values[0]) TautulliDatabaseValue.NAVIGATION_INDEX_GRAPHS.put(_values[1]);
            },
        ),
    );

    Widget get _defaultPageLibrariesDetailsTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [TautulliDatabaseValue.NAVIGATION_INDEX_LIBRARIES_DETAILS.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Library Details'),
            subtitle: LSSubtitle(text: TautulliLibrariesDetailsNavigationBar.titles[TautulliDatabaseValue.NAVIGATION_INDEX_LIBRARIES_DETAILS.data]),
            trailing: LSIconButton(icon: TautulliLibrariesDetailsNavigationBar.icons[TautulliDatabaseValue.NAVIGATION_INDEX_LIBRARIES_DETAILS.data]),
            onTap: () async {
                List<dynamic> _values = await TautulliDialogs.setDefaultPage(context, titles: TautulliLibrariesDetailsNavigationBar.titles, icons: TautulliLibrariesDetailsNavigationBar.icons);
                if(_values[0]) TautulliDatabaseValue.NAVIGATION_INDEX_LIBRARIES_DETAILS.put(_values[1]);
            },
        ),
    );

    Widget get _defaultPageMediaDetailsTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [TautulliDatabaseValue.NAVIGATION_INDEX_MEDIA_DETAILS.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Media Details'),
            subtitle: LSSubtitle(text: TautulliMediaDetailsNavigationBar.titles[TautulliDatabaseValue.NAVIGATION_INDEX_MEDIA_DETAILS.data]),
            trailing: LSIconButton(icon: TautulliMediaDetailsNavigationBar.icons[TautulliDatabaseValue.NAVIGATION_INDEX_MEDIA_DETAILS.data]),
            onTap: () async {
                List<dynamic> _values = await TautulliDialogs.setDefaultPage(context, titles: TautulliMediaDetailsNavigationBar.titles, icons: TautulliMediaDetailsNavigationBar.icons);
                if(_values[0]) TautulliDatabaseValue.NAVIGATION_INDEX_MEDIA_DETAILS.put(_values[1]);
            },
        ),
    );

    Widget get _defaultPageUserDetailsTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [TautulliDatabaseValue.NAVIGATION_INDEX_USER_DETAILS.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'User Details'),
            subtitle: LSSubtitle(text: TautulliUserDetailsNavigationBar.titles[TautulliDatabaseValue.NAVIGATION_INDEX_USER_DETAILS.data]),
            trailing: LSIconButton(icon: TautulliUserDetailsNavigationBar.icons[TautulliDatabaseValue.NAVIGATION_INDEX_USER_DETAILS.data]),
            onTap: () async {
                List<dynamic> _values = await TautulliDialogs.setDefaultPage(context, titles: TautulliUserDetailsNavigationBar.titles, icons: TautulliUserDetailsNavigationBar.icons);
                if(_values[0]) TautulliDatabaseValue.NAVIGATION_INDEX_USER_DETAILS.put(_values[1]);
            },
        ),
    );

    Widget get _defaultTerminationMessageTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [TautulliDatabaseValue.TERMINATION_MESSAGE.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Default Termination Message'),
            subtitle: LSSubtitle(text: (TautulliDatabaseValue.TERMINATION_MESSAGE.data as String).isEmpty ? 'Not Set' : TautulliDatabaseValue.TERMINATION_MESSAGE.data),
            trailing: LSIconButton(icon: Icons.videocam_off),
            onTap: () async {
                List<dynamic> _values = await TautulliDialogs.setTerminationMessage(context);
                if(_values[0]) TautulliDatabaseValue.TERMINATION_MESSAGE.put(_values[1]);
            },
        ),
    );

    Widget get _activityRefreshRateTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [TautulliDatabaseValue.REFRESH_RATE.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Refresh Rate'),
            subtitle: LSSubtitle(
                text: [
                    'Every',
                    TautulliDatabaseValue.REFRESH_RATE.data == 1 ? ' ' : ' ${TautulliDatabaseValue.REFRESH_RATE.data.toString()} ',
                    TautulliDatabaseValue.REFRESH_RATE.data == 1 ? 'Second' : 'Seconds'
                ].join(),
            ),
            trailing: LSIconButton(icon: Icons.refresh),
            onTap: () async {
                List<dynamic> _values = await TautulliDialogs.setRefreshRate(context);
                if(_values[0]) TautulliDatabaseValue.REFRESH_RATE.put(_values[1]);
            },
        ),
    );

    Widget get _statisticsItemCountTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [TautulliDatabaseValue.STATISTICS_STATS_COUNT.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Item Count'),
            subtitle: LSSubtitle(
                text: [
                    TautulliDatabaseValue.STATISTICS_STATS_COUNT.data.toString(),
                    TautulliDatabaseValue.STATISTICS_STATS_COUNT.data == 1 ? ' Item' : ' Items'
                ].join(),
            ),
            trailing: LSIconButton(icon: Icons.format_list_numbered),
            onTap: () async {
                List<dynamic> _values = await TautulliDialogs.setStatisticsItemCount(context);
                if(_values[0]) TautulliDatabaseValue.STATISTICS_STATS_COUNT.put(_values[1]);
            },
        ),
    );
}
