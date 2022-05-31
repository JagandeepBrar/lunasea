import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core/extensions.dart';
import 'package:lunasea/database/box.dart';
import 'package:lunasea/database/tables/dashboard.dart';
import 'package:lunasea/widgets/ui.dart';
import 'package:lunasea/vendor.dart';
import 'package:lunasea/modules/dashboard/core/adapters/calendar_starting_day.dart';
import 'package:lunasea/modules/dashboard/core/adapters/calendar_starting_size.dart';
import 'package:lunasea/modules/dashboard/core/api/data/abstract.dart';
import 'package:lunasea/modules/dashboard/core/api/data/lidarr.dart';
import 'package:lunasea/modules/dashboard/core/api/data/radarr.dart';
import 'package:lunasea/modules/dashboard/core/api/data/sonarr.dart';
import 'package:lunasea/modules/dashboard/core/state.dart';
import 'package:lunasea/modules/dashboard/routes/dashboard/widgets/content_block.dart';
import 'package:lunasea/modules/dashboard/routes/dashboard/widgets/navigation_bar.dart';

import 'package:provider/provider.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class CalendarView extends StatefulWidget {
  final Map<DateTime, List<CalendarData>> events;

  const CalendarView({
    Key? key,
    required this.events,
  }) : super(key: key);

  @override
  State<CalendarView> createState() => _State();
}

class _State extends State<CalendarView> {
  final double _calendarBulletSize = 8.0;
  List<CalendarData> _selectedEvents = [];

  late DateTime _selected;
  late CalendarFormat _calendarFormat;

  late final TextStyle dayStyle = _getTextStyle(LunaColours.white);
  late final TextStyle outsideStyle = _getTextStyle(LunaColours.white70);
  late final TextStyle unavailableStyle = _getTextStyle(LunaColours.white10);
  late final TextStyle weekdayStyle = _getTextStyle(LunaColours.accent);

  @override
  void initState() {
    super.initState();

    final size = DashboardDatabase.CALENDAR_STARTING_SIZE.read();
    _selected = context.read<ModuleState>().today!.lunaFloor;
    _selectedEvents = widget.events[_selected] ?? [];
    _calendarFormat = size.data;
  }

  TextStyle _getTextStyle(Color color) {
    return TextStyle(
      color: color,
      fontWeight: LunaUI.FONT_WEIGHT_BOLD,
      fontSize: LunaUI.FONT_SIZE_H3,
    );
  }

  void _onDaySelected(DateTime selected, DateTime focused) {
    HapticFeedback.selectionClick();
    if (mounted)
      setState(() {
        _selected = selected.lunaFloor;
        _selectedEvents = widget.events[selected.lunaFloor] ?? [];
      });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Column(
        children: [
          _calendar(),
          LunaDivider(),
          _calendarList(),
        ],
      ),
      padding: EdgeInsets.only(top: LunaUI.MARGIN_H_DEFAULT_V_HALF.top),
    );
  }

  Widget? _markerBuilder(
    BuildContext context,
    DateTime date,
    List<dynamic> events,
  ) {
    Color color;
    int missingCount = _countMissingContent(date, events);
    switch (missingCount) {
      case -100:
        color = Colors.transparent;
        break;
      case -1:
        color = LunaColours.blueGrey;
        break;
      case 0:
        color = LunaColours.accent;
        break;
      case 1:
        color = LunaColours.orange;
        break;
      case 2:
        color = LunaColours.orange;
        break;
      default:
        color = LunaColours.red;
        break;
    }
    return PositionedDirectional(
      bottom: 3.0,
      child: Container(
        width: _calendarBulletSize,
        height: _calendarBulletSize,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _calendar() {
    return ValueListenableBuilder(
      valueListenable: LunaBox.lunasea.box.listenable(keys: [
        DashboardDatabase.CALENDAR_STARTING_DAY.key,
        DashboardDatabase.CALENDAR_STARTING_SIZE.key,
      ]),
      builder: (context, dynamic box, _) {
        DateTime firstDay = context.watch<ModuleState>().today!.subtract(
              Duration(days: DashboardDatabase.CALENDAR_DAYS_PAST.read()),
            );
        DateTime lastDay = context.watch<ModuleState>().today!.add(
              Duration(days: DashboardDatabase.CALENDAR_DAYS_FUTURE.read()),
            );
        return SafeArea(
          child: LunaCard(
            context: context,
            child: Padding(
              child: TableCalendar(
                calendarBuilders: CalendarBuilders(
                  markerBuilder: _markerBuilder,
                ),
                rowHeight: 48.0,
                rangeSelectionMode: RangeSelectionMode.disabled,
                simpleSwipeConfig: const SimpleSwipeConfig(
                  verticalThreshold: 10.0,
                ),
                focusedDay: _selected,
                firstDay: firstDay,
                lastDay: lastDay,
                //events: widget.events,
                headerVisible: false,
                startingDayOfWeek:
                    DashboardDatabase.CALENDAR_STARTING_DAY.read().data,
                selectedDayPredicate: (date) =>
                    date.lunaFloor == _selected.lunaFloor,
                calendarStyle: CalendarStyle(
                  markersMaxCount: 1,
                  isTodayHighlighted: true,
                  outsideDaysVisible: false,
                  selectedDecoration: BoxDecoration(
                    color:
                        LunaColours.accent.withOpacity(LunaUI.OPACITY_SPLASH),
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: LunaColours.primary
                        .withOpacity(LunaUI.OPACITY_DISABLED),
                    shape: BoxShape.circle,
                  ),
                  weekendTextStyle: dayStyle,
                  defaultTextStyle: dayStyle,
                  disabledTextStyle: unavailableStyle,
                  outsideTextStyle: outsideStyle,
                  selectedTextStyle: const TextStyle(
                    color: LunaColours.accent,
                    fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                  ),
                  markersAlignment: Alignment.bottomCenter,
                  todayTextStyle: dayStyle,
                ),
                onFormatChanged: (format) =>
                    setState(() => _calendarFormat = format),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekendStyle: weekdayStyle,
                  weekdayStyle: weekdayStyle,
                ),
                eventLoader: (date) {
                  if (widget.events.isEmpty) return [];
                  return widget.events[date.lunaFloor] ?? [];
                },
                calendarFormat: _calendarFormat,
                availableCalendarFormats: const {
                  CalendarFormat.month: 'Month',
                  CalendarFormat.twoWeeks: '2 Weeks',
                  CalendarFormat.week: 'Week',
                },
                onDaySelected: _onDaySelected,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: LunaUI.DEFAULT_MARGIN_SIZE,
              ),
            ),
          ),
        );
      },
    );
  }

  /// -1: Date is after today (with content)
  /// -100: Event list was empty or null
  int _countMissingContent(DateTime date, List<dynamic> events) {
    DateTime _date = date.lunaFloor;
    DateTime _now = DateTime.now().lunaFloor;

    if (events.isEmpty) return -100;
    if (_date.isAfter(_now)) return -1;

    int counter = 0;
    for (dynamic event in events) {
      switch (event.runtimeType) {
        case CalendarLidarrData:
          if (!(event as CalendarLidarrData).hasAllFiles) counter++;
          break;
        case CalendarRadarrData:
          if (!(event as CalendarRadarrData).hasFile) counter++;
          break;
        case CalendarSonarrData:
          CalendarSonarrData _event = event;
          DateTime? _airTime = _event.airTimeObject?.toLocal();
          bool _isAired = _airTime?.isBefore(DateTime.now()) ?? false;
          if (!_event.hasFile && _isAired) counter++;
          break;
      }
    }
    return counter;
  }

  Widget _calendarList() {
    if (_selectedEvents.isEmpty) {
      return Expanded(
        child: LunaListView(
          controller: HomeNavigationBar.scrollControllers[1],
          children: [
            LunaMessage.inList(text: 'dashboard.NoNewContent'.tr()),
          ],
          padding:
              MediaQuery.of(context).padding.copyWith(top: 0.0, bottom: 8.0),
        ),
      );
    }

    return Expanded(
      child: LunaListView(
        controller: HomeNavigationBar.scrollControllers[1],
        children: _selectedEvents.map(ContentBlock.new).toList(),
        padding: MediaQuery.of(context).padding.copyWith(top: 0.0, bottom: 8.0),
      ),
    );
  }
}
