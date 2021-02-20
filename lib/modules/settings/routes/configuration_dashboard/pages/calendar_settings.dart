import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/dashboard.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationDashboardCalendarSettingsRouter extends LunaPageRouter {
    SettingsConfigurationDashboardCalendarSettingsRouter() : super('/settings/configuration/dashboard/calendar');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationLidarrRoute());
}

class _SettingsConfigurationLidarrRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationLidarrRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationLidarrRoute> with LunaScrollControllerMixin {
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
            title: 'Calendar Settings',
            scrollControllers: [scrollController],
        );
    }

    Widget _body() {
        return LunaListView(
            controller: scrollController,
            children: [
                _pastDays(),
                _futureDays(),
                LunaDivider(),
                _startingDay(),
                _startingSize(),
                _startingType(),
                LunaDivider(),
                _modulesLidarr(),
                _modulesRadarr(),
                _modulesSonarr(),
            ],
        );
    }

    Widget _pastDays() {
        return DashboardDatabaseValue.CALENDAR_DAYS_PAST.listen(
            builder: (context, box, widget) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Past Days'),
                subtitle: LunaText.subtitle(text: DashboardDatabaseValue.CALENDAR_DAYS_PAST.data == 1
                    ? '1 Day'
                    : '${DashboardDatabaseValue.CALENDAR_DAYS_PAST.data} Days',
                ),
                trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
                onTap: () async {
                    List _values = await DashboardDialogs.setPastDays(context);
                    if(_values[0]) DashboardDatabaseValue.CALENDAR_DAYS_PAST.put(_values[1]);
                },
            ),
        );
    }

    Widget _futureDays() {
        return DashboardDatabaseValue.CALENDAR_DAYS_FUTURE.listen(
            builder: (context, box, widget) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Future Days'),
                subtitle: LunaText.subtitle(text: DashboardDatabaseValue.CALENDAR_DAYS_FUTURE.data == 1
                    ? '1 Day'
                    : '${DashboardDatabaseValue.CALENDAR_DAYS_FUTURE.data} Days',
                ),
                trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
                onTap: () async {
                    List _values = await DashboardDialogs.setFutureDays(context);
                    if(_values[0]) DashboardDatabaseValue.CALENDAR_DAYS_FUTURE.put(_values[1]);
                },
            ),
        );
    }

    Widget _modulesLidarr() {
        return DashboardDatabaseValue.CALENDAR_ENABLE_LIDARR.listen(
            builder: (context, box, widget) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Lidarr'),
                    subtitle: LunaText.subtitle(text: 'Show Lidarr Calendar Entries'),
                trailing: LunaSwitch(
                    value: DashboardDatabaseValue.CALENDAR_ENABLE_LIDARR.data,
                    onChanged: (value) => DashboardDatabaseValue.CALENDAR_ENABLE_LIDARR.put(value),
                ),
            ),
        );
    }

    Widget _modulesRadarr() {
        return DashboardDatabaseValue.CALENDAR_ENABLE_RADARR.listen(
            builder: (context, box, widget) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Radarr'),
                    subtitle: LunaText.subtitle(text: 'Show Radarr Calendar Entries'),
                trailing: LunaSwitch(
                    value: DashboardDatabaseValue.CALENDAR_ENABLE_RADARR.data,
                    onChanged: (value) => DashboardDatabaseValue.CALENDAR_ENABLE_RADARR.put(value),
                ),
            ),
        );
    }

    Widget _modulesSonarr() {
        return DashboardDatabaseValue.CALENDAR_ENABLE_SONARR.listen(
            builder: (context, box, widget) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Sonarr'),
                subtitle: LunaText.subtitle(text: 'Show Sonarr Calendar Entries'),
                trailing: LunaSwitch(
                    value: DashboardDatabaseValue.CALENDAR_ENABLE_SONARR.data,
                    onChanged: (value) => DashboardDatabaseValue.CALENDAR_ENABLE_SONARR.put(value),
                ),
            ),
        );
    }

    Widget _startingType() {
        return DashboardDatabaseValue.CALENDAR_STARTING_TYPE.listen(
            builder: (context, box, widget) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Starting Type'),
                subtitle: LunaText.subtitle(text: (DashboardDatabaseValue.CALENDAR_STARTING_TYPE.data as CalendarStartingType).name),
                trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
                onTap: () async {
                    List _values = await SettingsDialogs.editCalendarStartingType(context);
                    if(_values[0]) DashboardDatabaseValue.CALENDAR_STARTING_TYPE.put(_values[1]);
                },
            ),
        );
    }

    Widget _startingDay() {
        return DashboardDatabaseValue.CALENDAR_STARTING_DAY.listen(
            builder: (context, box, widget) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Starting Day'),
                subtitle: LunaText.subtitle(text: (DashboardDatabaseValue.CALENDAR_STARTING_DAY.data as CalendarStartingDay).name),
                trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
                onTap: () async {
                    List _values = await SettingsDialogs.editCalendarStartingDay(context);
                    if(_values[0]) DashboardDatabaseValue.CALENDAR_STARTING_DAY.put(_values[1]);
                },
            ),
        );
    }

    Widget _startingSize() {
        return DashboardDatabaseValue.CALENDAR_STARTING_SIZE.listen(
            builder: (context, box, widget) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Starting Size'),
                subtitle: LunaText.subtitle(text: (DashboardDatabaseValue.CALENDAR_STARTING_SIZE.data as CalendarStartingSize).name),
                trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
                onTap: () async {
                    List _values = await SettingsDialogs.editCalendarStartingSize(context);
                    if(_values[0]) DashboardDatabaseValue.CALENDAR_STARTING_SIZE.put(_values[1]);
                },
            ),
        );
    }
}
