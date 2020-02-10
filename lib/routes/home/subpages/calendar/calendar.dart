import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/home/widgets.dart';

class Calendar extends StatefulWidget {
    @override
    State<Calendar> createState() => _State();
}

class _State extends State<Calendar> {
    final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
    final _today = DateTime.now();
    Map<DateTime, List> _events;
    bool _loading = true;

    @override
    initState() {
        super.initState();
        _events = {
            _today: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
        };
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
        await Future.delayed(Duration(seconds: 2)).then((_) {});
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
                    ? Notifications.centeredMessage('Loading...')
                    : CalendarWidget(
                        events: _events,
                        today: _today
                    ),
            ),
        );
    }
}
