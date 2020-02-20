import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/system.dart';
import 'package:lunasea/widgets/pages/home.dart';
import 'package:lunasea/widgets/ui.dart' as UI;

class Calendar extends StatefulWidget {
    final CalendarAPI api = CalendarAPI.from(Database.getProfileObject());
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

    Calendar({
        Key key,
        @required this.refreshIndicatorKey,
    }) : super(key: key);

    @override
    State<Calendar> createState() => _State();
}

class _State extends State<Calendar> {
    DateTime _today;
    Map<DateTime, List> _events;
    bool _loading = true;

    @override
    initState() {
        super.initState();
        Future.delayed(Duration(milliseconds: 200)).then((_) {
            if(mounted) {
                widget.refreshIndicatorKey?.currentState?.show();
            } 
        });
    }

    Future<void> _handleRefresh() async {
        if(mounted) setState(() {
            _loading = true;
        });
        _today = DateTime.now().lsDateTime_floor();
        _events = await widget.api.getUpcoming(_today);
        if(mounted) setState(() {
            _loading = false;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: RefreshIndicator(
                key: widget.refreshIndicatorKey,
                onRefresh: _handleRefresh,
                backgroundColor: Color(Constants.SECONDARY_COLOR),
                child: _loading
                    ? UI.LSLoading()
                    : _events == null
                        ? UI.LSConnectionError(onTapHandler: () {
                            widget.refreshIndicatorKey?.currentState?.show();
                        })
                        : CalendarWidget(
                            events: _events,
                            today: _today,
                        ),
            ),
        );
    }
}
