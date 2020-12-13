import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/home/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationCalendarRouter extends LunaPageRouter {
    static const ROUTE_NAME = '/settings/configuration/calendar';

    Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        ROUTE_NAME,
    );

    String route(List parameters) => ROUTE_NAME;
    
    void defineRoutes(FluroRouter router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => _Widget()),
        transitionType: LunaRouter.transitionType,
    );
}

class _Widget extends StatefulWidget {
    @override
    State<_Widget> createState() => _State();
}

class _State extends State<_Widget> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Calendar',
    );

    Widget get _body => LSListView(
        children: [
            LSHeader(
                text: 'Date Range',
                subtitle: 'Choose how far in the past and future the calendar will fetch data',
            ),
            _pastDaysTile,
            _futureDaysTile,
            LSHeader(
                text: 'Starting Options',
                subtitle: 'Set the default starting date, size, and type of the calendar',
            ),
            _startingDayTile,
            _startingSizeTile,
            _startingTypeTile,
            LSHeader(
                text: 'Modules',
                subtitle: 'Choose which modules\'s data should be fetched',
            ),
            _modulesEnableLidarrTile,
            _modulesEnableRadarrTile,
            _modulesEnableSonarrTile,
        ],
    );

    Widget get _pastDaysTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [HomeDatabaseValue.CALENDAR_DAYS_PAST.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Past Days'),
            subtitle: LSSubtitle(text: HomeDatabaseValue.CALENDAR_DAYS_PAST.data == 1
                ? '1 Day'
                : '${HomeDatabaseValue.CALENDAR_DAYS_PAST.data} Days',
            ),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async {
                List _values = await HomeDialogs.setPastDays(context);
                if(_values[0]) HomeDatabaseValue.CALENDAR_DAYS_PAST.put(_values[1]);
            },
        ),
    );

    Widget get _futureDaysTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [HomeDatabaseValue.CALENDAR_DAYS_FUTURE.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Future Days'),
            subtitle: LSSubtitle(text: HomeDatabaseValue.CALENDAR_DAYS_FUTURE.data == 1
                ? '1 Day'
                : '${HomeDatabaseValue.CALENDAR_DAYS_FUTURE.data} Days',
            ),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async {
                List _values = await HomeDialogs.setFutureDays(context);
                if(_values[0]) HomeDatabaseValue.CALENDAR_DAYS_FUTURE.put(_values[1]);
            },
        ),
    );

    Widget get _modulesEnableLidarrTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [HomeDatabaseValue.CALENDAR_ENABLE_LIDARR.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Show Lidarr'),
            subtitle: LSSubtitle(text: 'Show Lidarr Calendar Entries'),
            trailing: Switch(
                value: HomeDatabaseValue.CALENDAR_ENABLE_LIDARR.data,
                onChanged: (value) => HomeDatabaseValue.CALENDAR_ENABLE_LIDARR.put(value),
            ),
        ),
    );

    Widget get _modulesEnableRadarrTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [HomeDatabaseValue.CALENDAR_ENABLE_RADARR.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Show Radarr'),
            subtitle: LSSubtitle(text: 'Show Radarr Calendar Entries'),
            trailing: Switch(
                value: HomeDatabaseValue.CALENDAR_ENABLE_RADARR.data,
                onChanged: (value) => HomeDatabaseValue.CALENDAR_ENABLE_RADARR.put(value),
            ),
        ),
    );

    Widget get _modulesEnableSonarrTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [HomeDatabaseValue.CALENDAR_ENABLE_SONARR.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Show Sonarr'),
            subtitle: LSSubtitle(text: 'Show Sonarr Calendar Entries'),
            trailing: Switch(
                value: HomeDatabaseValue.CALENDAR_ENABLE_SONARR.data,
                onChanged: (value) => HomeDatabaseValue.CALENDAR_ENABLE_SONARR.put(value),
            ),
        ),
    );

    Widget get _startingTypeTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [HomeDatabaseValue.CALENDAR_STARTING_TYPE.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Starting Type'),
            subtitle: LSSubtitle(text: (HomeDatabaseValue.CALENDAR_STARTING_TYPE.data as CalendarStartingType).name),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async {
                List _values = await SettingsDialogs.editCalendarStartingType(context);
                if(_values[0]) HomeDatabaseValue.CALENDAR_STARTING_TYPE.put(_values[1]);
            },
        ),
    );

    Widget get _startingDayTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [HomeDatabaseValue.CALENDAR_STARTING_DAY.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Starting Day'),
            subtitle: LSSubtitle(text: (HomeDatabaseValue.CALENDAR_STARTING_DAY.data as CalendarStartingDay).name),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async {
                List _values = await SettingsDialogs.editCalendarStartingDay(context);
                if(_values[0]) HomeDatabaseValue.CALENDAR_STARTING_DAY.put(_values[1]);
            },
        ),
    );

    Widget get _startingSizeTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [HomeDatabaseValue.CALENDAR_STARTING_SIZE.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Starting Size'),
            subtitle: LSSubtitle(text: (HomeDatabaseValue.CALENDAR_STARTING_SIZE.data as CalendarStartingSize).name),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async {
                List _values = await SettingsDialogs.editCalendarStartingSize(context);
                if(_values[0]) HomeDatabaseValue.CALENDAR_STARTING_SIZE.put(_values[1]);
            },
        ),
    );
}
