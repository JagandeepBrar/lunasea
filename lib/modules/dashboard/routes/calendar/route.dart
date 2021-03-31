import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/dashboard.dart';

class DashboardCalendarRoute extends StatefulWidget {
    @override
    State<DashboardCalendarRoute> createState() => _State();
}

class _State extends State<DashboardCalendarRoute> with AutomaticKeepAliveClientMixin, LunaLoadCallbackMixin {
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    @override
    bool get wantKeepAlive => true;

    Future<void> loadCallback() async {
        context.read<DashboardState>().resetUpcoming();
    }

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return LunaRefreshIndicator(
            context: context,
            key: _refreshKey,
            onRefresh: loadCallback,
            child: FutureBuilder(
                future: context.watch<DashboardState>().upcoming,
                builder: (context, snapshot) {
                    if(snapshot.hasError) {
                        if(snapshot.connectionState != ConnectionState.waiting) LunaLogger().error(
                            'Failed to fetch unified calendar data',
                            snapshot.error,
                            snapshot.stackTrace,
                        );
                        return LunaMessage.error(onTap: _refreshKey.currentState?.show);
                    }
                    if(snapshot.connectionState == ConnectionState.done && snapshot.hasData) return DashboardCalendarWidget(
                        events: snapshot.data,
                    );
                    return LunaLoader();
                },
            ),
        );
    }
}
