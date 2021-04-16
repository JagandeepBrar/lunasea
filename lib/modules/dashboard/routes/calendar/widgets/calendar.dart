import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/dashboard.dart';
import 'package:table_calendar/table_calendar.dart';

class DashboardCalendarWidget extends StatefulWidget {
    final Map<DateTime, List> events;

    DashboardCalendarWidget({
        Key key,
        @required this.events,
    }) : super(key: key);

    @override
    State<DashboardCalendarWidget> createState() => _State();
}

class _State extends State<DashboardCalendarWidget> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    DateTime _today;

    final TextStyle dayTileStyle = TextStyle(
        color: Colors.white,
        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
        fontSize: LunaUI.FONT_SIZE_SUBTITLE,
    );
    final TextStyle outsideDayTileStyle = TextStyle(
        color: Colors.white54,
        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
        fontSize: LunaUI.FONT_SIZE_SUBTITLE,
    );
    final TextStyle unavailableTitleStyle = TextStyle(
        color: Colors.white12,
        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
        fontSize: LunaUI.FONT_SIZE_SUBTITLE,
    );
    final TextStyle weekdayTitleStyle = TextStyle(
        color: LunaColours.accent,
        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
        fontSize: LunaUI.FONT_SIZE_SUBTITLE,
    );
    
    List _selectedEvents;
    CalendarController _calendarController;

    @override
    void initState() {
        super.initState();
        _calendarController = CalendarController();
        _today = context.read<DashboardState>().today.lunaFloor;
        _selectedEvents = widget.events[_today] ?? [];
    }

    @override
    void dispose() {
        _calendarController.dispose();
        super.dispose();
    }

    void _onDaySelected(DateTime day, List events, List _) {
        HapticFeedback.selectionClick();
        setState(() {
            _selectedEvents = events;
        });
    }

    @override
    Widget build(BuildContext context) {
        return  LunaScaffold(
            scaffoldKey: _scaffoldKey,
            body: Selector<DashboardState, CalendarStartingType>(
                selector: (_, state) => state.calendarStartingType,
                builder: (context, startingType, _) {
                    if(startingType == CalendarStartingType.CALENDAR) {
                        return Padding(
                            child: Column(
                                children: [
                                    _calendar(),
                                    _calendarList(),
                                ],
                            ),
                            padding: EdgeInsets.only(top: 8.0),
                        );
                    }
                    return _schedule();
                },
            )
        );
    }

    Widget _calendar() {
        return ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [
                DashboardDatabaseValue.CALENDAR_STARTING_DAY.key,
                DashboardDatabaseValue.CALENDAR_STARTING_SIZE.key,
            ]),
            builder: (context, box, _) {
                return SafeArea(
                    child: LunaCard(
                        context: context,
                        child: Padding(
                            child: TableCalendar(
                                rowHeight: 48.0,
                                calendarController: _calendarController,
                                events: widget.events,
                                headerVisible: false,
                                startDay: DateTime.now().subtract(Duration(days: DashboardDatabaseValue.CALENDAR_DAYS_PAST.data)),
                                endDay: DateTime.now().add(Duration(days: DashboardDatabaseValue.CALENDAR_DAYS_FUTURE.data)),
                                startingDayOfWeek: (DashboardDatabaseValue.CALENDAR_STARTING_DAY.data as CalendarStartingDay).data,
                                calendarStyle: CalendarStyle(
                                    selectedColor: LunaColours.accent.withOpacity(0.25),
                                    markersMaxAmount: 1,
                                    markersColor: LunaColours.accent,
                                    weekendStyle: dayTileStyle,
                                    weekdayStyle: dayTileStyle,
                                    unavailableStyle: unavailableTitleStyle,
                                    outsideStyle: outsideDayTileStyle,
                                    selectedStyle: dayTileStyle,
                                    outsideWeekendStyle: outsideDayTileStyle,
                                    renderDaysOfWeek: true,
                                    highlightToday: true,
                                    todayColor: LunaColours.primary,
                                    todayStyle: dayTileStyle,
                                    outsideDaysVisible: false,
                                ),
                                daysOfWeekStyle: DaysOfWeekStyle(
                                    weekendStyle: weekdayTitleStyle,
                                    weekdayStyle: weekdayTitleStyle,
                                ),
                                initialCalendarFormat: (DashboardDatabaseValue.CALENDAR_STARTING_SIZE.data as CalendarStartingSize).data,
                                availableCalendarFormats: const {
                                    CalendarFormat.month : 'Month', CalendarFormat.twoWeeks : '2 Weeks', CalendarFormat.week : 'Week'},
                                onDaySelected: _onDaySelected,
                            ),
                            padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                        ),
                    ),
                );
            },
        );
    }

    Widget _calendarList() {
        if((_selectedEvents?.length ?? 0) == 0) return Expanded(
            child: LunaListView(
                controller: DashboardNavigationBar.scrollControllers[1],
                children: [
                    LunaMessage.inList(text: 'No New Content'),
                ],
            ),
        );
        return Expanded(
            child: LunaListView(
                controller: DashboardNavigationBar.scrollControllers[1],
                children: _selectedEvents.map((event) => _entry(event)).toList(),
                padding: MediaQuery.of(context).padding.copyWith(top: 0.0, bottom: 8.0),
            ),
        );
    }

    Widget _schedule() {
        if((widget.events?.length ?? 0) == 0) return LunaListView(
            controller: DashboardNavigationBar.scrollControllers[1],
            children: [
                LunaMessage.inList(text: 'No New Content'),
            ],
        );
        return LunaListView(
            controller: DashboardNavigationBar.scrollControllers[1],
            children: _buildDays().expand((element) => element).toList(),
        );
    }

    List<List<Widget>> _buildDays() {
        List<List<Widget>> days = [];
        List<DateTime> keys = widget.events.keys.toList();
        keys.sort();
        for(var key in keys) {
            if(key.isAfter(_today.subtract(Duration(days: 1))) &&  widget.events[key].length > 0) days.add(_day(key));
        }
        return days;
    }

    List<Widget> _day(DateTime day) {
        List<Widget> listCards = [];
        for(int i=0; i<widget.events[day].length; i++) listCards.add(_entry(widget.events[day][i]));
        return [
            LunaHeader(
                text: DateFormat('EEEE / MMMM dd, y').format(day)
            ),
            ...listCards,
        ];
    }

    Widget _entry(dynamic event) {
        Map headers;
        switch(event.runtimeType) {
            case CalendarLidarrData: headers = Database.currentProfileObject.getLidarr()['headers']; break;
            case CalendarRadarrData: headers = Database.currentProfileObject.getRadarr()['headers']; break;
            case CalendarSonarrData: headers = Database.currentProfileObject.getSonarr()['headers']; break;
            default: headers = {}; break;
        }
        return LunaListTile(
            context: context,
            title: LunaText.title(text: event.title),
            subtitle: RichText(
                text: event.subtitle,
                overflow: TextOverflow.fade,
                softWrap: false,
                maxLines: 2,
            ),
            trailing: event.trailing(context),
            onTap: () async => event.enterContent(context),
            contentPadding: true,
            decoration: LunaCardDecoration(
                uri: event.bannerURI,
                headers: headers,
            ),
        );
    }
}
