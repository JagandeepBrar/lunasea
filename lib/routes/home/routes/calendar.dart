import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/pages/home.dart';
import 'package:lunasea/widgets/ui.dart';

class HomeCalendar extends StatefulWidget {
    static const ROUTE_NAME = '/home/calendar';
    final CalendarAPI api = CalendarAPI.from(Database.currentProfileObject);
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

    HomeCalendar({
        Key key,
        @required this.refreshIndicatorKey,
    }) : super(key: key);

    @override
    State<HomeCalendar> createState() => _State();
}

class _State extends State<HomeCalendar> {
    DateTime _today;
    Future<Map<DateTime, List>> _future;
    Map<DateTime, List> _events;

    @override
    initState() {
        super.initState();
        _refresh();
    }

    Future<void> _refresh() async {
        _today = DateTime.now().lsDateTime_floor();
        setState(() {
            _future = widget.api.getUpcoming(_today);
        });
    }

    @override
    Widget build(BuildContext context) => LSRefreshIndicator(
        refreshKey: widget.refreshIndicatorKey,
        onRefresh: _refresh,
        child: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
                switch(snapshot.connectionState) {
                    case ConnectionState.done: {
                        if(snapshot.hasError || snapshot.data == null) return LSErrorMessage(onTapHandler: () => _refresh());
                        _events = snapshot.data;
                        return _list;
                    }
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                    default: return LSLoading();
                }
            },
        ),
    );

    Widget get _list => CalendarWidget(
        events: _events,
        today: _today,
    );
}
