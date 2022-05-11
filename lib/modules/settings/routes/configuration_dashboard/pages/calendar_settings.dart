import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import 'package:lunasea/core/modules.dart';
import 'package:lunasea/widgets/ui.dart';
import 'package:lunasea/modules/dashboard/core/adapters/calendar_starting_day.dart';
import 'package:lunasea/modules/dashboard/core/adapters/calendar_starting_size.dart';
import 'package:lunasea/modules/dashboard/core/adapters/calendar_starting_type.dart';
import 'package:lunasea/modules/dashboard/core/database.dart';
import 'package:lunasea/modules/dashboard/core/dialogs.dart';
import 'package:lunasea/modules/settings/core/dialogs.dart';
import 'package:lunasea/modules/settings/core/router.dart';

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
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'settings.CalendarSettings'.tr(),
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
        LunaDivider(),
        _startingDay(),
        _startingSize(),
        _startingView(),
        LunaDivider(),
        _modulesLidarr(),
        _modulesRadarr(),
        _modulesSonarr(),
      ],
    );
  }

  Widget _pastDaysInSchedule() {
    DashboardDatabaseValue _db = DashboardDatabaseValue.CALENDAR_SHOW_PAST_DAYS;
    return _db.listen(
      builder: (context, box, widget) => LunaBlock(
        title: 'settings.PastDaysInScheduleView'.tr(),
        trailing: LunaSwitch(
          value: _db.data,
          onChanged: _db.put,
        ),
      ),
    );
  }

  Widget _pastDays() {
    DashboardDatabaseValue _db = DashboardDatabaseValue.CALENDAR_DAYS_PAST;
    return _db.listen(
      builder: (context, box, widget) => LunaBlock(
        title: 'settings.PastDays'.tr(),
        body: [
          TextSpan(
            text: _db.data == 1
                ? 'settings.DaysOne'.tr()
                : 'settings.DaysCount'.tr(args: [_db.data.toString()]),
          ),
        ],
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          Tuple2<bool, int> result =
              await DashboardDialogs().setPastDays(context);
          if (result.item1) _db.put(result.item2);
        },
      ),
    );
  }

  Widget _futureDays() {
    DashboardDatabaseValue _db = DashboardDatabaseValue.CALENDAR_DAYS_FUTURE;
    return _db.listen(
      builder: (context, box, widget) => LunaBlock(
        title: 'settings.FutureDays'.tr(),
        body: [
          TextSpan(
            text: _db.data == 1
                ? 'settings.DaysOne'.tr()
                : 'settings.DaysCount'.tr(args: [_db.data.toString()]),
          ),
        ],
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          Tuple2<bool, int> result =
              await DashboardDialogs().setFutureDays(context);
          if (result.item1) _db.put(result.item2);
        },
      ),
    );
  }

  Widget _modulesLidarr() {
    DashboardDatabaseValue _db = DashboardDatabaseValue.CALENDAR_ENABLE_LIDARR;
    return _db.listen(
      builder: (context, box, widget) => LunaBlock(
        title: LunaModule.LIDARR.name,
        body: [
          TextSpan(
            text: 'settings.ShowCalendarEntries'.tr(
              args: [LunaModule.LIDARR.name],
            ),
          )
        ],
        trailing: LunaSwitch(
          value: _db.data,
          onChanged: _db.put,
        ),
      ),
    );
  }

  Widget _modulesRadarr() {
    DashboardDatabaseValue _db = DashboardDatabaseValue.CALENDAR_ENABLE_RADARR;
    return _db.listen(
      builder: (context, box, widget) => LunaBlock(
        title: LunaModule.RADARR.name,
        body: [
          TextSpan(
            text: 'settings.ShowCalendarEntries'.tr(
              args: [LunaModule.RADARR.name],
            ),
          )
        ],
        trailing: LunaSwitch(
          value: _db.data,
          onChanged: _db.put,
        ),
      ),
    );
  }

  Widget _modulesSonarr() {
    DashboardDatabaseValue _db = DashboardDatabaseValue.CALENDAR_ENABLE_SONARR;
    return _db.listen(
      builder: (context, box, widget) => LunaBlock(
        title: LunaModule.SONARR.name,
        body: [
          TextSpan(
            text: 'settings.ShowCalendarEntries'.tr(
              args: [LunaModule.SONARR.name],
            ),
          )
        ],
        trailing: LunaSwitch(
          value: _db.data,
          onChanged: _db.put,
        ),
      ),
    );
  }

  Widget _startingView() {
    DashboardDatabaseValue _db = DashboardDatabaseValue.CALENDAR_STARTING_TYPE;
    return _db.listen(
      builder: (context, box, widget) => LunaBlock(
        title: 'settings.StartingView'.tr(),
        body: [
          TextSpan(text: (_db.data as CalendarStartingType).name),
        ],
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          Tuple2<bool, CalendarStartingType?> _values =
              await SettingsDialogs().editCalendarStartingView(context);
          if (_values.item1) _db.put(_values.item2);
        },
      ),
    );
  }

  Widget _startingDay() {
    DashboardDatabaseValue _db = DashboardDatabaseValue.CALENDAR_STARTING_DAY;
    return _db.listen(
      builder: (context, box, widget) => LunaBlock(
        title: 'settings.StartingDay'.tr(),
        body: [
          TextSpan(text: (_db.data as CalendarStartingDay).name),
        ],
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          Tuple2<bool, CalendarStartingDay?> results =
              await SettingsDialogs().editCalendarStartingDay(context);
          if (results.item1) _db.put(results.item2);
        },
      ),
    );
  }

  Widget _startingSize() {
    DashboardDatabaseValue _db = DashboardDatabaseValue.CALENDAR_STARTING_SIZE;
    return _db.listen(
      builder: (context, box, widget) => LunaBlock(
        title: 'settings.StartingSize'.tr(),
        body: [
          TextSpan(text: (_db.data as CalendarStartingSize).name),
        ],
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          Tuple2<bool, CalendarStartingSize?> _values =
              await SettingsDialogs().editCalendarStartingSize(context);
          if (_values.item1) _db.put(_values.item2);
        },
      ),
    );
  }
}
