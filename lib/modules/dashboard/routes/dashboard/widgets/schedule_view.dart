import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/extensions.dart';
import '../../../../../core/ui.dart';
import '../../../core/api/data/abstract.dart';
import '../../../core/database.dart';
import '../../../core/state.dart';
import 'content_block.dart';
import 'navigation_bar.dart';

class ScheduleView extends StatefulWidget {
  final Map<DateTime, List<CalendarData>> events;

  const ScheduleView({
    Key? key,
    required this.events,
  }) : super(key: key);

  @override
  State<ScheduleView> createState() => _State();
}

class _State extends State<ScheduleView> {
  late DateTime _today;

  @override
  void initState() {
    super.initState();
    DateTime _floored = context.read<ModuleState>().today!.lunaFloor;
    _today = _floored;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.events.isEmpty) {
      return LunaListView(
        controller: HomeNavigationBar.scrollControllers[1],
        children: [
          LunaMessage.inList(text: 'dashboard.NoNewContent'.tr()),
        ],
      );
    }
    return LunaListView(
      controller: HomeNavigationBar.scrollControllers[1],
      children: _buildSchedule().expand((e) => e).toList(),
    );
  }

  List<List<Widget>> _buildSchedule() {
    List<List<Widget>> days = [];
    List<DateTime> keys = widget.events.keys.toList();
    keys.sort();

    for (var key in keys) {
      bool pastDays = DashboardDatabaseValue.CALENDAR_SHOW_PAST_DAYS.data;
      bool dayInFuture = key.isAfter(_today.subtract(const Duration(days: 1)));
      bool hasEvents = widget.events[key]?.isNotEmpty ?? false;
      if ((pastDays || dayInFuture) && hasEvents) days.add(_buildDay(key));
    }

    return days;
  }

  List<Widget> _buildDay(DateTime day) {
    List<Widget> content = [];
    List<CalendarData> events = widget.events[day]!;
    for (final event in events) content.add(ContentBlock(event));

    return [
      LunaHeader(text: DateFormat('EEEE / MMMM dd, y').format(day)),
      ...content,
    ];
  }
}
