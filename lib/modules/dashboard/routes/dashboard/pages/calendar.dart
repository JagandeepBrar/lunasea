import 'package:flutter/material.dart';

import '../../../../../core/mixins/load_callback.dart';
import '../../../../../core/extensions.dart';
import '../../../../../core/ui.dart';
import '../../../../../core/utilities/logger.dart';
import '../../../../../vendor.dart';
import '../../../core/adapters/calendar_starting_type.dart';
import '../../../core/api/data/abstract.dart';
import '../../../core/state.dart';
import '../widgets/calendar_view.dart';
import '../widgets/schedule_view.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _State();
}

class _State extends State<CalendarPage>
    with AutomaticKeepAliveClientMixin, LunaLoadCallbackMixin {
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

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
        builder: (
          BuildContext context,
          AsyncSnapshot<Map<DateTime, List<CalendarData>>> snapshot,
        ) {
          if (snapshot.hasError) {
            LunaLogger().error(
              'Failed to fetch unified calendar data',
              snapshot.error,
              snapshot.stackTrace,
            );
            return LunaMessage.error(onTap: _refreshKey.currentState!.show);
          }

          if (snapshot.lunaIsFinishedWithData) {
            final events = snapshot.data!;
            return Selector<ModuleState, CalendarStartingType>(
              selector: (_, s) => s.calendarStartingType,
              builder: (context, type, _) {
                if (type == CalendarStartingType.CALENDAR)
                  return CalendarView(events: events);
                else
                  return ScheduleView(events: events);
              },
            );
          }

          return const LunaLoader();
        },
      ),
    );
  }
}
