import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/system.dart';
import 'package:lunasea/widgets/pages/home.dart';
import 'package:lunasea/widgets/ui.dart' as UI;

class Calendar extends StatefulWidget {
    @override
    State<Calendar> createState() => _State();
}

class _State extends State<Calendar> {
    final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
    DateTime _today;
    Map<DateTime, List> _events;
    bool _loading = true;

    @override
    initState() {
        super.initState();
        Future.delayed(Duration(milliseconds: 200)).then((_) {
            if(mounted) {
                _refreshIndicatorKey?.currentState?.show();
            } 
        });
    }

    Future<void> _handleRefresh() async {
        if(mounted) setState(() {
            _loading = true;
        });
        CalendarAPI api = CalendarAPI();
        _today = DateTime.now().lsDateTime_floor();
        _events = await api.getUpcoming(_today);
        if(mounted) setState(() {
            _loading = false;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: _handleRefresh,
                backgroundColor: Color(Constants.SECONDARY_COLOR),
                child: _loading
                    ? UI.Loading()
                    : _events == null
                        ? UI.ConnectionError(onTapHandler: () {
                            _refreshIndicatorKey?.currentState?.show();
                        })
                        : CalendarWidget(
                            events: _events,
                            today: _today,
                        ),
            ),
        );
    }
}
