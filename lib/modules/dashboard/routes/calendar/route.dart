import 'package:flutter/material.dart';

import '../../../../core/mixins/load_callback.dart';
import '../../../../core/ui.dart';
import '../../../../core/utilities/logger.dart';
import '../../../../vendor.dart';
import '../../core/api/data/abstract.dart';
import '../../core/state.dart';
import 'widgets/calendar.dart';

class DashboardCalendarRoute extends StatefulWidget {
  const DashboardCalendarRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<DashboardCalendarRoute> createState() => _State();
}

class _State extends State<DashboardCalendarRoute>
    with AutomaticKeepAliveClientMixin, LunaLoadCallbackMixin {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Future<void> loadCallback() async {
    context.read<ModuleState>().resetToday();
    context.read<ModuleState>().resetUpcoming();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: loadCallback,
      child: FutureBuilder(
        future: context.watch<ModuleState>().upcoming,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              LunaLogger().error(
                'Failed to fetch unified calendar data',
                snapshot.error,
                snapshot.stackTrace,
              );
            }
            return LunaMessage.error(onTap: _refreshKey.currentState!.show);
          }
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return DashboardCalendarWidget(
              events: snapshot.data as Map<DateTime, List<CalendarData>>,
            );
          }
          return const LunaLoader();
        },
      ),
    );
  }
}
