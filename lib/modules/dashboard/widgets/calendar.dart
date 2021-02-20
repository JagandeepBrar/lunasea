import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/dashboard.dart';
import 'package:table_calendar/table_calendar.dart';

class DashboardCalendarWidget extends StatefulWidget {
    final Map<DateTime, List> events;
    final DateTime today;

    DashboardCalendarWidget({
        Key key,
        @required this.events,
        @required this.today,
    }) : super(key: key);

    @override
    State<DashboardCalendarWidget> createState() => _State();
}

class _State extends State<DashboardCalendarWidget> with TickerProviderStateMixin {
    final TextStyle dayTileStyle = TextStyle(
        color: Colors.white,
        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
        fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
    );
    final TextStyle outsideDayTileStyle = TextStyle(
        color: Colors.white30,
        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
        fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
    );
    final TextStyle weekdayTitleStyle = TextStyle(
        color: LunaColours.accent,
        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
        fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
    );
    
    List _selectedEvents;
    AnimationController _animationController;
    CalendarController _calendarController;

    @override
    void initState() {
        super.initState();
        _selectedEvents = widget.events[widget.today] ?? [];
        _calendarController = CalendarController();
        _animationController = AnimationController( vsync: this, duration: kThemeAnimationDuration);
        _animationController?.forward();
    }

    @override
    void dispose() {
        _animationController.dispose();
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
        return Scaffold(
            body: Provider.of<DashboardState>(context).calendarStartingType == CalendarStartingType.CALENDAR
                ? Padding(
                    child: Column(
                        children: [
                            _calendar,
                            _list,
                        ],
                    ),
                    padding: EdgeInsets.only(top: 8.0),
                )
                : _schedule
        );
    }

    Widget get _calendar => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [
            DashboardDatabaseValue.CALENDAR_STARTING_DAY.key,
            DashboardDatabaseValue.CALENDAR_STARTING_SIZE.key,
        ]),
        builder: (context, box, _) => LSCard(
            child: Padding(
                child: TableCalendar(
                    rowHeight: 48.0,
                    calendarController: _calendarController,
                    events: widget.events,
                    startingDayOfWeek: (DashboardDatabaseValue.CALENDAR_STARTING_DAY.data as CalendarStartingDay).data,
                    calendarStyle: CalendarStyle(
                        selectedColor: LunaColours.accent.withOpacity(0.25),
                        markersMaxAmount: 1,
                        markersColor: LunaColours.accent,
                        weekendStyle: dayTileStyle,
                        weekdayStyle: dayTileStyle,
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
                    headerStyle: HeaderStyle(
                        titleTextStyle: TextStyle(
                            fontSize: Constants.UI_FONT_SIZE_HEADER,
                            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                        ),
                        centerHeaderTitle: true,
                        formatButtonVisible: false,
                        leftChevronIcon: Icon(Icons.arrow_back_ios),
                        rightChevronIcon: Icon(Icons.arrow_forward_ios),
                    ),
                    initialCalendarFormat: (DashboardDatabaseValue.CALENDAR_STARTING_SIZE.data as CalendarStartingSize).data,
                    availableCalendarFormats: const {
                        CalendarFormat.month : 'Month', CalendarFormat.twoWeeks : '2 Weeks', CalendarFormat.week : 'Week'},
                    onDaySelected: _onDaySelected,
                ),
                padding: EdgeInsets.only(bottom: 12.0),
            ),
        ),
    );

    Widget get _list => Expanded(
        child: LSListView(
            children: _selectedEvents.length == 0 
                ? [LSGenericMessage(text: 'No New Content')]
                : _selectedEvents.map((event) => _entry(event)).toList(),
            customPadding: EdgeInsets.only(bottom: 8.0),
        ),
    );

    Widget get _schedule => LSListView(
        children: widget.events.length == 0
            ? [LSGenericMessage(text: 'No New Content')]
            : _days.expand((element) => element).toList(),
    );

    List<List<Widget>> get _days {
        List<List<Widget>> days = [];
        List<DateTime> keys = widget.events.keys.toList();
        keys.sort();
        for(var key in keys) {
            if(key.isAfter(widget.today.subtract(Duration(days: 1))) &&  widget.events[key].length > 0) days.add(_day(key));
        }
        return days;
    }

    List<Widget> _day(DateTime day) {
        List<Widget> listCards = [];
        for(int i=0; i<widget.events[day].length; i++) listCards.add(_entry(widget.events[day][i]));
        return [
            LSHeader(
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
        return LSCardTile(
            title: LSTitle(text: event.title),
            subtitle: RichText(
                text: event.subtitle,
                overflow: TextOverflow.fade,
                softWrap: false,
                maxLines: 2,
            ),
            trailing: event.trailing(context),
            onTap: () async => event.enterContent(context),
            padContent: true,
            decoration: LunaCardDecoration(
                uri: event.bannerURI,
                headers: headers,
            ),
        );
    }
}
