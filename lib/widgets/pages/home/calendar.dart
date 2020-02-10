import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
    final Map<DateTime, List> events;
    final DateTime today;

    CalendarWidget({
        Key key,
        @required this.events,
        @required this.today,
    }) : super(key: key);

    @override
    State<CalendarWidget> createState() => _State();
}

class _State extends State<CalendarWidget> with TickerProviderStateMixin {
    final TextStyle dayTileStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.w600);
    final TextStyle outsideDayTileStyle = TextStyle(color: Colors.white30, fontWeight: FontWeight.w600);
    

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

    void _onDaySelected(DateTime day, List events) {
        setState(() {
            _selectedEvents = events;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Padding(
                child: Column(
                    children: <Widget>[
                        _buildCalendar(),
                        Elements.getDivider(),
                        _buildList(),
                    ],
                ),
                padding: EdgeInsets.only(top: 8.0),
            ),
        );
    }

    Widget _buildCalendar() {
        return Card(
            child: Padding(
                child: TableCalendar(
                    calendarController: _calendarController,
                    events: widget.events,
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    calendarStyle: CalendarStyle(
                        selectedColor: Color(Constants.PRIMARY_COLOR),
                        markersMaxAmount: 3,
                        markersColor: Color(Constants.ACCENT_COLOR),
                        weekendStyle: dayTileStyle,
                        weekdayStyle: dayTileStyle,
                        outsideStyle: outsideDayTileStyle,
                        selectedStyle: dayTileStyle,
                        outsideWeekendStyle: outsideDayTileStyle,
                        renderDaysOfWeek: false,
                        highlightToday: false,
                        outsideDaysVisible: false,
                    ),
                    headerStyle: HeaderStyle(
                        titleTextStyle: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                        ),
                        centerHeaderTitle: true,
                        formatButtonVisible: false,
                        leftChevronIcon: Elements.getIcon(Icons.arrow_back_ios),
                        rightChevronIcon: Elements.getIcon(Icons.arrow_forward_ios),
                    ),
                    initialCalendarFormat: CalendarFormat.twoWeeks,
                    availableCalendarFormats: const {
                        CalendarFormat.month : 'Month', CalendarFormat.twoWeeks : '2 Weeks', CalendarFormat.week : 'Week'},
                    onDaySelected: _onDaySelected,
                ),
                padding: EdgeInsets.only(bottom: 12.0),
            ),
            margin: Elements.getCardMargin(),
            elevation: 4.0,
        );
    }

    Widget _buildList() {
        return Expanded(
            child: Scrollbar(
                child: ListView(
                    children: _selectedEvents
                        .map((event) => _buildListEntry(event)).toList(),     
                    padding: EdgeInsets.only(bottom: 8.0),     
                ),
            ),
        );
    }

    Widget _buildListEntry(dynamic event) {
        return Card(
            child: Container(
                child: ListTile(
                    title: Elements.getTitle(event.title),
                    subtitle: RichText(
                        text: event.subtitle,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        maxLines: 2,
                    ),
                    trailing: IconButton(
                        icon: Elements.getIcon(Icons.arrow_forward_ios),
                        onPressed: null,
                    ),
                    onTap: () async {
                        await event.enterContent(context);
                    },
                    contentPadding: Elements.getContentPadding(),
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AdvancedNetworkImage(
                            event.bannerURI,
                            useDiskCache: true,
                            loadFailedCallback: () {},
                            fallbackAssetImage: 'assets/images/secondary_color.png',
                            retryLimit: 1,
                        ),
                        colorFilter: ColorFilter.mode(Color(Constants.SECONDARY_COLOR).withOpacity(0.20), BlendMode.dstATop),
                        fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                ),
            ),
            margin: Elements.getCardMargin(),
            elevation: 4.0,
        );
    }
}
