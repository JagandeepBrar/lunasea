import 'package:flutter/material.dart';
import 'package:lunasea/database/tables/dashboard.dart';
import 'package:lunasea/vendor.dart';

import 'package:lunasea/modules.dart';
import 'package:lunasea/widgets/ui.dart';
import 'package:lunasea/modules/dashboard/core/adapters/calendar_starting_day.dart';
import 'package:lunasea/modules/dashboard/core/adapters/calendar_starting_size.dart';
import 'package:lunasea/modules/dashboard/core/adapters/calendar_starting_type.dart';
import 'package:lunasea/modules/dashboard/core/dialogs.dart';
import 'package:lunasea/modules/settings/core/dialogs.dart';

class ConfigurationDashboardCalendarRoute extends StatefulWidget {
  const ConfigurationDashboardCalendarRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationDashboardCalendarRoute> createState() => _State();
}

class _State extends State<ConfigurationDashboardCalendarRoute>
    with LunaScrollControllerMixin {
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

  Widget _pastDays() {
    const _db = DashboardDatabase.CALENDAR_DAYS_PAST;
    return _db.listenableBuilder(
      builder: (context, _) => LunaBlock(
        title: 'settings.PastDays'.tr(),
        body: [
          TextSpan(
            text: _db.read() == 1
                ? 'settings.DaysOne'.tr()
                : 'settings.DaysCount'.tr(args: [_db.read().toString()]),
          ),
        ],
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          Tuple2<bool, int> result =
              await DashboardDialogs().setPastDays(context);
          if (result.item1) _db.update(result.item2);
        },
      ),
    );
  }

  Widget _futureDays() {
    const _db = DashboardDatabase.CALENDAR_DAYS_FUTURE;
    return _db.listenableBuilder(
      builder: (context, _) => LunaBlock(
        title: 'settings.FutureDays'.tr(),
        body: [
          TextSpan(
            text: _db.read() == 1
                ? 'settings.DaysOne'.tr()
                : 'settings.DaysCount'.tr(args: [_db.read().toString()]),
          ),
        ],
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          Tuple2<bool, int> result =
              await DashboardDialogs().setFutureDays(context);
          if (result.item1) _db.update(result.item2);
        },
      ),
    );
  }

  Widget _modulesLidarr() {
    const _db = DashboardDatabase.CALENDAR_ENABLE_LIDARR;
    return _db.listenableBuilder(
      builder: (context, _) => LunaBlock(
        title: LunaModule.LIDARR.title,
        body: [
          TextSpan(
            text: 'settings.ShowCalendarEntries'.tr(
              args: [LunaModule.LIDARR.title],
            ),
          )
        ],
        trailing: LunaSwitch(
          value: _db.read(),
          onChanged: _db.update,
        ),
      ),
    );
  }

  Widget _modulesRadarr() {
    const _db = DashboardDatabase.CALENDAR_ENABLE_RADARR;
    return _db.listenableBuilder(
      builder: (context, _) => LunaBlock(
        title: LunaModule.RADARR.title,
        body: [
          TextSpan(
            text: 'settings.ShowCalendarEntries'.tr(
              args: [LunaModule.RADARR.title],
            ),
          )
        ],
        trailing: LunaSwitch(
          value: _db.read(),
          onChanged: _db.update,
        ),
      ),
    );
  }

  Widget _modulesSonarr() {
    const _db = DashboardDatabase.CALENDAR_ENABLE_SONARR;
    return _db.listenableBuilder(
      builder: (context, _) => LunaBlock(
        title: LunaModule.SONARR.title,
        body: [
          TextSpan(
            text: 'settings.ShowCalendarEntries'.tr(
              args: [LunaModule.SONARR.title],
            ),
          )
        ],
        trailing: LunaSwitch(
          value: _db.read(),
          onChanged: _db.update,
        ),
      ),
    );
  }

  Widget _startingView() {
    const _db = DashboardDatabase.CALENDAR_STARTING_TYPE;
    return _db.listenableBuilder(
      builder: (context, _) => LunaBlock(
        title: 'settings.StartingView'.tr(),
        body: [
          TextSpan(text: _db.read().name),
        ],
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          Tuple2<bool, CalendarStartingType?> _values =
              await SettingsDialogs().editCalendarStartingView(context);
          if (_values.item1) _db.update(_values.item2!);
        },
      ),
    );
  }

  Widget _startingDay() {
    const _db = DashboardDatabase.CALENDAR_STARTING_DAY;
    return _db.listenableBuilder(
      builder: (context, _) => LunaBlock(
        title: 'settings.StartingDay'.tr(),
        body: [
          TextSpan(text: _db.read().name),
        ],
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          Tuple2<bool, CalendarStartingDay?> results =
              await SettingsDialogs().editCalendarStartingDay(context);
          if (results.item1) _db.update(results.item2!);
        },
      ),
    );
  }

  Widget _startingSize() {
    const _db = DashboardDatabase.CALENDAR_STARTING_SIZE;
    return _db.listenableBuilder(
      builder: (context, _) => LunaBlock(
        title: 'settings.StartingSize'.tr(),
        body: [
          TextSpan(text: _db.read().name),
        ],
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          Tuple2<bool, CalendarStartingSize?> _values =
              await SettingsDialogs().editCalendarStartingSize(context);
          if (_values.item1) _db.update(_values.item2!);
        },
      ),
    );
  }
}
