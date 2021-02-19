import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:lunasea/modules/settings.dart';

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
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar(),
            body: _body(),
        );
    }

    Widget _appBar() {
        return LunaAppBar(
            title: 'Tautulli',
            actions: [
                LunaIconButton(
                    icon: Icons.help_outline,
                    onPressed: () async => SettingsDialogs.moduleInformation(context, LunaModule.TAUTULLI),
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
                _defaultPagesPage(),
                _activityRefreshRate(),
                _defaultTerminationMessage(),
                _statisticsItemCount(),
            ],
        );
    }

    Widget _enabledToggle() {
        return ValueListenableBuilder(
            valueListenable: Database.profilesBox.listenable(),
            builder: (context, _, __) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Enable ${LunaModule.TAUTULLI.name}'),
                trailing: LunaSwitch(
                    value: Database.currentProfileObject.tautulliEnabled ?? false,
                    onChanged: (value) {
                        Database.currentProfileObject.tautulliEnabled = value;
                        Database.currentProfileObject.save();
                        context.read<TautulliState>().reset();
                    },
                ),
            ),
        );
    }

    Widget _connectionDetailsPage() {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Connection Details'),
            subtitle: LunaText.subtitle(text: 'Connection Details for Tautulli'),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async => SettingsConfigurationTautulliConnectionDetailsRouter().navigateTo(context),
        );
    }

    Widget _defaultPagesPage() {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Default Pages'),
            subtitle: LunaText.subtitle(text: 'Set Default Landing Pages'),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async => SettingsConfigurationTautulliDefaultPagesRouter().navigateTo(context),
        );
    }

    Widget _defaultTerminationMessage() {
        return TautulliDatabaseValue.TERMINATION_MESSAGE.listen(
            builder: (context, box, _) {
                String terminationMessage = TautulliDatabaseValue.TERMINATION_MESSAGE.data;
                return LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Default Termination Message'),
                    subtitle: LunaText.subtitle(text: terminationMessage.isEmpty ? 'Not Set' : terminationMessage),
                    trailing: LunaIconButton(icon: Icons.videocam_off),
                    onTap: () async {
                    Tuple2<bool, String> result = await TautulliDialogs.setTerminationMessage(context);
                        if(result.item1) TautulliDatabaseValue.TERMINATION_MESSAGE.put(result.item2);
                    },
                );
            },
        );
    }

    Widget _activityRefreshRate() {
        return TautulliDatabaseValue.REFRESH_RATE.listen(
            builder: (context, box, _) {
                String refreshRate;
                if(TautulliDatabaseValue.REFRESH_RATE.data == 1) refreshRate = 'Every Second';
                if(TautulliDatabaseValue.REFRESH_RATE.data != 1) refreshRate = 'Every ${TautulliDatabaseValue.REFRESH_RATE.data} Seconds';
                return LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Activity Refresh Rate'),
                    subtitle: LunaText.subtitle(text: refreshRate),
                    trailing: LunaIconButton(icon: Icons.refresh),
                    onTap: () async {
                        List<dynamic> _values = await TautulliDialogs.setRefreshRate(context);
                        if(_values[0]) TautulliDatabaseValue.REFRESH_RATE.put(_values[1]);
                    },
                );
            }
        );
    }

    Widget _statisticsItemCount() {
        return ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [TautulliDatabaseValue.STATISTICS_STATS_COUNT.key]),
            builder: (context, box, _) {
                String statisticsItems;
                if(TautulliDatabaseValue.STATISTICS_STATS_COUNT.data == 1) statisticsItems = '1 Item';
                if(TautulliDatabaseValue.STATISTICS_STATS_COUNT.data != 1) statisticsItems = '${TautulliDatabaseValue.STATISTICS_STATS_COUNT.data} Items';
                return LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Statistics Item Count'),
                    subtitle: LunaText.subtitle(text: statisticsItems),
                    trailing: LunaIconButton(icon: Icons.format_list_numbered),
                    onTap: () async {
                        List<dynamic> _values = await TautulliDialogs.setStatisticsItemCount(context);
                        if(_values[0]) TautulliDatabaseValue.STATISTICS_STATS_COUNT.put(_values[1]);
                    },
                );
            },
        );
    }
}
