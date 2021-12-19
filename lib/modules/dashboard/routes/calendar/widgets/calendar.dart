import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/dashboard.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'package:table_calendar/table_calendar.dart';

class DashboardCalendarWidget extends StatefulWidget {
  final Map<DateTime, List<CalendarData>> events;

  const DashboardCalendarWidget({
    Key key,
    @required this.events,
  }) : super(key: key);

  @override
  State<DashboardCalendarWidget> createState() => _State();
}

class _State extends State<DashboardCalendarWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime _today;
  DateTime _selected;
  CalendarFormat _calendarFormat;

  final TextStyle dayTileStyle = const TextStyle(
    color: LunaColours.white,
    fontWeight: LunaUI.FONT_WEIGHT_BOLD,
    fontSize: LunaUI.FONT_SIZE_H3,
  );
  final TextStyle outsideDayTileStyle = const TextStyle(
    color: LunaColours.white70,
    fontWeight: LunaUI.FONT_WEIGHT_BOLD,
    fontSize: LunaUI.FONT_SIZE_H3,
  );
  final TextStyle unavailableTitleStyle = const TextStyle(
    color: LunaColours.white10,
    fontWeight: LunaUI.FONT_WEIGHT_BOLD,
    fontSize: LunaUI.FONT_SIZE_H3,
  );
  final TextStyle weekdayTitleStyle = const TextStyle(
    color: LunaColours.accent,
    fontWeight: LunaUI.FONT_WEIGHT_BOLD,
    fontSize: LunaUI.FONT_SIZE_H3,
  );

  final double _calendarBulletSize = 8.0;
  List<CalendarData> _selectedEvents;

  @override
  void initState() {
    super.initState();
    DateTime _floored = context.read<DashboardState>().today.lunaFloor;
    _selected = _floored;
    _today = _floored;
    _selectedEvents = widget.events[_floored] ?? [];
    _calendarFormat = (DashboardDatabaseValue.CALENDAR_STARTING_SIZE.data
            as CalendarStartingSize)
        .data;
  }

  void _onDaySelected(DateTime selected, DateTime focused) {
    HapticFeedback.selectionClick();
    if (mounted)
      setState(() {
        _selected = selected.lunaFloor;
        _selectedEvents = widget.events[selected.lunaFloor];
      });
  }

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
        scaffoldKey: _scaffoldKey,
        body: Selector<DashboardState, CalendarStartingType>(
          selector: (_, state) => state.calendarStartingType,
          builder: (context, startingType, _) {
            if (startingType == CalendarStartingType.CALENDAR) {
              return Padding(
                child: Column(
                  children: [
                    _calendar(),
                    const LunaDivider(),
                    _calendarList(),
                  ],
                ),
                padding:
                    EdgeInsets.only(top: LunaUI.MARGIN_H_DEFAULT_V_HALF.top),
              );
            }
            return _schedule();
          },
        ));
  }

  Widget _markerBuilder(
    BuildContext context,
    DateTime date,
    List<CalendarData> events,
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
      valueListenable: Database.lunaSeaBox.listenable(keys: [
        DashboardDatabaseValue.CALENDAR_STARTING_DAY.key,
        DashboardDatabaseValue.CALENDAR_STARTING_SIZE.key,
      ]),
      builder: (context, box, _) {
        DateTime firstDay = context.watch<DashboardState>().today.subtract(
              Duration(days: DashboardDatabaseValue.CALENDAR_DAYS_PAST.data),
            );
        DateTime lastDay = context.watch<DashboardState>().today.add(
              Duration(days: DashboardDatabaseValue.CALENDAR_DAYS_FUTURE.data),
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
                startingDayOfWeek: (DashboardDatabaseValue
                        .CALENDAR_STARTING_DAY.data as CalendarStartingDay)
                    .data,
                selectedDayPredicate: (date) =>
                    date?.lunaFloor == _selected?.lunaFloor,
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
                  weekendTextStyle: dayTileStyle,
                  defaultTextStyle: dayTileStyle,
                  disabledTextStyle: unavailableTitleStyle,
                  outsideTextStyle: outsideDayTileStyle,
                  selectedTextStyle: const TextStyle(
                    color: LunaColours.accent,
                    fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                  ),
                  markersAlignment: Alignment.bottomCenter,
                  todayTextStyle: dayTileStyle,
                ),
                onFormatChanged: (format) =>
                    setState(() => _calendarFormat = format),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekendStyle: weekdayTitleStyle,
                  weekdayStyle: weekdayTitleStyle,
                ),
                eventLoader: (date) => widget.events[date.lunaFloor],
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
  int _countMissingContent(DateTime date, List<CalendarData> events) {
    DateTime _date = date.lunaFloor;
    DateTime _now = DateTime.now().lunaFloor;

    if (events == null || events.isEmpty) return -100;
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
          DateTime _airTime = _event.airTimeObject?.toLocal();
          bool _isAired = _airTime?.isBefore(DateTime.now()) ?? false;
          if (!_event.hasFile && _isAired) counter++;
          break;
      }
    }
    return counter;
  }

  Widget _calendarList() {
    if ((_selectedEvents?.length ?? 0) == 0)
      return Expanded(
        child: LunaListView(
          controller: DashboardNavigationBar.scrollControllers[1],
          children: [
            LunaMessage.inList(text: 'dashboard.NoNewContent'.tr()),
          ],
          padding:
              MediaQuery.of(context).padding.copyWith(top: 0.0, bottom: 8.0),
        ),
      );
    return Expanded(
      child: LunaListView(
        controller: DashboardNavigationBar.scrollControllers[1],
        children: _selectedEvents.map(_entry).toList(),
        padding: MediaQuery.of(context).padding.copyWith(top: 0.0, bottom: 8.0),
      ),
    );
  }

  Widget _schedule() {
    if ((widget.events?.length ?? 0) == 0)
      return LunaListView(
        controller: DashboardNavigationBar.scrollControllers[1],
        children: [
          LunaMessage.inList(text: 'dashboard.NoNewContent'.tr()),
        ],
      );
    return LunaListView(
      controller: DashboardNavigationBar.scrollControllers[1],
      children: _buildScheduleDays().expand((element) => element).toList(),
    );
  }

  List<List<Widget>> _buildScheduleDays() {
    List<List<Widget>> days = [];
    List<DateTime> keys = widget.events.keys.toList();
    keys.sort();
    for (var key in keys) {
      bool _showPastDays = DashboardDatabaseValue.CALENDAR_SHOW_PAST_DAYS.data;
      bool _dayInFuture = key.isAfter(_today.subtract(const Duration(days: 1)));
      bool _dayHasEvents = widget.events[key].isNotEmpty;
      if ((_showPastDays || _dayInFuture) && _dayHasEvents) {
        days.add(_day(key));
      }
    }
    return days;
  }

  List<Widget> _day(DateTime day) {
    List<Widget> listCards = [];
    for (int i = 0; i < widget.events[day].length; i++)
      listCards.add(_entry(widget.events[day][i]));
    return [
      LunaHeader(text: DateFormat('EEEE / MMMM dd, y').format(day)),
      ...listCards,
    ];
  }

  Widget _entry(CalendarData event) {
    Map headers;
    switch (event.runtimeType) {
      case CalendarLidarrData:
        headers = Database.currentProfileObject.getLidarr()['headers'];
        break;
      case CalendarRadarrData:
        headers = Database.currentProfileObject.getRadarr()['headers'];
        break;
      case CalendarSonarrData:
        headers = Database.currentProfileObject.getSonarr()['headers'];
        break;
      default:
        headers = const {};
        break;
    }
    return LunaBlock(
      title: event.title,
      body: event.body,
      posterHeaders: headers,
      backgroundHeaders: headers,
      posterUrl: event.posterUrl(context),
      posterPlaceholderIcon: LunaIcons.VIDEO_CAM,
      backgroundUrl: event.backgroundUrl(context),
      trailing: event.trailing(context),
      onTap: () async => event.enterContent(context),
    );
  }
}
