import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/home.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationHomeRouter extends LunaPageRouter {
    SettingsConfigurationHomeRouter() : super('/settings/configuration/home');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationHomeRoute());
}

class _SettingsConfigurationHomeRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationHomeRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationHomeRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(title: 'Home');

    Widget get _body => LSListView(
        children: [
            LSHeader(text: 'Default Pages'),
            _defaultPageTile,
            LSHeader(text: 'Appearance'),
            _brandColoursTile,
            LSHeader(text: 'Calendar Date Range'),
            _pastDaysTile,
            _futureDaysTile,
            LSHeader(text: 'Calendar Options'),
            _startingDayTile,
            _startingSizeTile,
            _startingTypeTile,
            LSHeader(text: 'Calendar Modules'),
            _modulesEnableLidarrTile,
            _modulesEnableRadarrTile,
            _modulesEnableSonarrTile,
        ],
    );

    Widget get _brandColoursTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [HomeDatabaseValue.MODULES_BRAND_COLOURS.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Use Brand Colours'),
            subtitle: LSSubtitle(text: 'For Module Icons'),
            trailing: LunaSwitch(
                value: HomeDatabaseValue.MODULES_BRAND_COLOURS.data,
                onChanged: (value) => HomeDatabaseValue.MODULES_BRAND_COLOURS.put(value),
            ),
        ),
    );

    Widget get _defaultPageTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [HomeDatabaseValue.NAVIGATION_INDEX.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Home'),
            subtitle: LSSubtitle(text: HomeNavigationBar.titles[HomeDatabaseValue.NAVIGATION_INDEX.data]),
            trailing: LSIconButton(icon: HomeNavigationBar.icons[HomeDatabaseValue.NAVIGATION_INDEX.data]),
            onTap: () async {
                List<dynamic> _values = await HomeDialogs.defaultPage(context);
                if(_values[0]) HomeDatabaseValue.NAVIGATION_INDEX.put(_values[1]);
            },
        ),
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
            title: LSTitle(text: 'Lidarr'),
            subtitle: LSSubtitle(text: HomeDatabaseValue.CALENDAR_ENABLE_LIDARR.data ? 'Showing Lidarr Entries' : 'Hiding Lidarr Entries'),
            trailing: LunaSwitch(
                value: HomeDatabaseValue.CALENDAR_ENABLE_LIDARR.data,
                onChanged: (value) => HomeDatabaseValue.CALENDAR_ENABLE_LIDARR.put(value),
            ),
        ),
    );

    Widget get _modulesEnableRadarrTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [HomeDatabaseValue.CALENDAR_ENABLE_RADARR.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Radarr'),
            subtitle: LSSubtitle(text: HomeDatabaseValue.CALENDAR_ENABLE_RADARR.data ? 'Showing Radarr Entries' : 'Hiding Radarr Entries'),
            trailing: LunaSwitch(
                value: HomeDatabaseValue.CALENDAR_ENABLE_RADARR.data,
                onChanged: (value) => HomeDatabaseValue.CALENDAR_ENABLE_RADARR.put(value),
            ),
        ),
    );

    Widget get _modulesEnableSonarrTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [HomeDatabaseValue.CALENDAR_ENABLE_SONARR.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Sonarr'),
            subtitle: LSSubtitle(text: HomeDatabaseValue.CALENDAR_ENABLE_SONARR.data ? 'Showing Sonarr Entries' : 'Hiding Sonarr Entries'),
            trailing: LunaSwitch(
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
