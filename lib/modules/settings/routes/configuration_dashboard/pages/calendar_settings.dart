import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/dashboard.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationDashboardCalendarSettingsRouter
    extends SettingsPageRouter {
  SettingsConfigurationDashboardCalendarSettingsRouter()
      : super('/settings/configuration/dashboard/calendar');

  @override
  _Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) {
    super.noParameterRouteDefinition(router);
  }
}

class _Widget extends StatefulWidget {
  @override
  State<_Widget> createState() => _State();
}

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
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
        _futureDays(),
        _pastDays(),
        _pastDaysInSchedule(),
        const LunaDivider(),
        _startingDay(),
        _startingSize(),
        _startingView(),
        const LunaDivider(),
        _modulesLidarr(),
        _modulesRadarr(),
        _modulesSonarr(),
      ],
    );
  }

  Widget _pastDaysInSchedule() {
    return DashboardDatabaseValue.CALENDAR_SHOW_PAST_DAYS.listen(
      builder: (context, box, widget) => LunaListTile(
        context: context,
        title: LunaText.title(text: 'Past Days In Schedule View'),
        trailing: LunaSwitch(
          value: DashboardDatabaseValue.CALENDAR_SHOW_PAST_DAYS.data,
          onChanged: DashboardDatabaseValue.CALENDAR_SHOW_PAST_DAYS.put,
        ),
      ),
    );
  }

  Widget _pastDays() {
    return DashboardDatabaseValue.CALENDAR_DAYS_PAST.listen(
      builder: (context, box, widget) => LunaListTile(
        context: context,
        title: LunaText.title(text: 'Past Days'),
        subtitle: LunaText.subtitle(
          text: DashboardDatabaseValue.CALENDAR_DAYS_PAST.data == 1
              ? '1 Day'
              : '${DashboardDatabaseValue.CALENDAR_DAYS_PAST.data} Days',
        ),
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          Tuple2<bool, int> result =
              await DashboardDialogs().setPastDays(context);
          if (result.item1) {
            DashboardDatabaseValue.CALENDAR_DAYS_PAST.put(result.item2);
          }
        },
      ),
    );
  }

  Widget _futureDays() {
    return DashboardDatabaseValue.CALENDAR_DAYS_FUTURE.listen(
      builder: (context, box, widget) => LunaListTile(
        context: context,
        title: LunaText.title(text: 'Future Days'),
        subtitle: LunaText.subtitle(
          text: DashboardDatabaseValue.CALENDAR_DAYS_FUTURE.data == 1
              ? '1 Day'
              : '${DashboardDatabaseValue.CALENDAR_DAYS_FUTURE.data} Days',
        ),
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          Tuple2<bool, int> result =
              await DashboardDialogs().setFutureDays(context);
          if (result.item1) {
            DashboardDatabaseValue.CALENDAR_DAYS_FUTURE.put(result.item2);
          }
        },
      ),
    );
  }

  Widget _modulesLidarr() {
    return DashboardDatabaseValue.CALENDAR_ENABLE_LIDARR.listen(
      builder: (context, box, widget) => LunaListTile(
        context: context,
        title: LunaText.title(text: LunaModule.LIDARR.name),
        subtitle: LunaText.subtitle(
          text:
              'settings.ShowCalendarEntries'.tr(args: [LunaModule.LIDARR.name]),
        ),
        trailing: LunaSwitch(
          value: DashboardDatabaseValue.CALENDAR_ENABLE_LIDARR.data,
          onChanged: (value) {
            DashboardDatabaseValue.CALENDAR_ENABLE_LIDARR.put(value);
          },
        ),
      ),
    );
  }

  Widget _modulesRadarr() {
    return DashboardDatabaseValue.CALENDAR_ENABLE_RADARR.listen(
      builder: (context, box, widget) => LunaListTile(
        context: context,
        title: LunaText.title(text: LunaModule.RADARR.name),
        subtitle: LunaText.subtitle(
          text:
              'settings.ShowCalendarEntries'.tr(args: [LunaModule.RADARR.name]),
        ),
        trailing: LunaSwitch(
          value: DashboardDatabaseValue.CALENDAR_ENABLE_RADARR.data,
          onChanged: (value) {
            DashboardDatabaseValue.CALENDAR_ENABLE_RADARR.put(value);
          },
        ),
      ),
    );
  }

  Widget _modulesSonarr() {
    return DashboardDatabaseValue.CALENDAR_ENABLE_SONARR.listen(
      builder: (context, box, widget) => LunaListTile(
        context: context,
        title: LunaText.title(text: LunaModule.SONARR.name),
        subtitle: LunaText.subtitle(
          text:
              'settings.ShowCalendarEntries'.tr(args: [LunaModule.SONARR.name]),
        ),
        trailing: LunaSwitch(
          value: DashboardDatabaseValue.CALENDAR_ENABLE_SONARR.data,
          onChanged: (value) {
            DashboardDatabaseValue.CALENDAR_ENABLE_SONARR.put(value);
          },
        ),
      ),
    );
  }

  Widget _startingView() {
    return DashboardDatabaseValue.CALENDAR_STARTING_TYPE.listen(
      builder: (context, box, widget) => LunaListTile(
        context: context,
        title: LunaText.title(text: 'settings.StartingView'.tr()),
        subtitle: LunaText.subtitle(
            text: (DashboardDatabaseValue.CALENDAR_STARTING_TYPE.data
                    as CalendarStartingType)
                .name),
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          Tuple2<bool, CalendarStartingType> _values =
              await SettingsDialogs().editCalendarStartingView(context);
          if (_values.item1) {
            DashboardDatabaseValue.CALENDAR_STARTING_TYPE.put(_values.item2);
          }
        },
      ),
    );
  }

  Widget _startingDay() {
    return DashboardDatabaseValue.CALENDAR_STARTING_DAY.listen(
      builder: (context, box, widget) => LunaListTile(
        context: context,
        title: LunaText.title(text: 'settings.StartingDay'.tr()),
        subtitle: LunaText.subtitle(
            text: (DashboardDatabaseValue.CALENDAR_STARTING_DAY.data
                    as CalendarStartingDay)
                .name),
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          Tuple2<bool, CalendarStartingDay> results =
              await SettingsDialogs().editCalendarStartingDay(context);
          if (results.item1) {
            DashboardDatabaseValue.CALENDAR_STARTING_DAY.put(results.item2);
          }
        },
      ),
    );
  }

  Widget _startingSize() {
    return DashboardDatabaseValue.CALENDAR_STARTING_SIZE.listen(
      builder: (context, box, widget) => LunaListTile(
        context: context,
        title: LunaText.title(text: 'Starting Size'),
        subtitle: LunaText.subtitle(
            text: (DashboardDatabaseValue.CALENDAR_STARTING_SIZE.data
                    as CalendarStartingSize)
                .name),
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          Tuple2<bool, CalendarStartingSize> _values =
              await SettingsDialogs().editCalendarStartingSize(context);
          if (_values.item1) {
            DashboardDatabaseValue.CALENDAR_STARTING_SIZE.put(_values.item2);
          }
        },
      ),
    );
  }
}
