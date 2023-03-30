import 'package:flutter/material.dart';
import 'package:lunasea/extensions/scroll_controller.dart';
import 'package:lunasea/vendor.dart';

import 'package:lunasea/widgets/ui.dart';
import 'package:lunasea/modules/dashboard/core/api/data/abstract.dart';
import 'package:lunasea/modules/dashboard/core/state.dart';
import 'package:lunasea/modules/dashboard/routes/dashboard/widgets/content_block.dart';
import 'package:lunasea/modules/dashboard/routes/dashboard/widgets/navigation_bar.dart';

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
  final _formatter = DateFormat('EEEE / MMMM dd, y');

  @override
  Widget build(BuildContext context) {
    final controller = HomeNavigationBar.scrollControllers[1];

    if (widget.events.isEmpty) {
      return LunaListView(
        controller: controller,
        children: [
          LunaMessage.inList(text: 'dashboard.NoNewContent'.tr()),
        ],
      );
    }

    final schedule = _buildSchedule();
    Future.microtask(() => controller.animateToOffset(schedule.item2));

    return LunaCustomScrollView(
      controller: controller,
      slivers: [
        const SliverPadding(
          padding: EdgeInsets.symmetric(vertical: LunaUI.MARGIN_SIZE_HALF),
        ),
        ...schedule.item1,
        const SliverPadding(
          padding: EdgeInsets.only(bottom: LunaUI.MARGIN_SIZE_HALF),
        ),
      ],
    );
  }

  Tuple2<List<Widget>, double> _buildSchedule() {
    double offset = 0.0;
    double offsetOfSelected = 0.0;

    List<Widget> days = [];
    List<DateTime> keys = widget.events.keys.toList();
    keys.sort();

    for (final key in keys) {
      final selected = context.read<DashboardState>().selected;
      if (key.isBefore(selected) || key.isAtSameMomentAs(selected)) {
        offsetOfSelected = offset;
      }

      final hasEvents = widget.events[key]?.isNotEmpty ?? false;
      if (hasEvents) {
        final built = _buildDay(key);
        offset += built.item2;
        days.addAll(built.item1);
      }
    }

    return Tuple2(days, offsetOfSelected);
  }

  Tuple2<List<Widget>, double> _buildDay(DateTime day) {
    List<CalendarData> events = widget.events[day]!;

    final extent = LunaBlock.calculateItemExtent(3);
    final offset = 39.30 + events.length * extent;
    final slivers = [
      SliverToBoxAdapter(
        child: LunaHeader(text: _formatter.format(day)),
      ),
      SliverFixedExtentList(
        delegate: SliverChildBuilderDelegate(
          (_, index) => ContentBlock(events[index]),
          childCount: events.length,
        ),
        itemExtent: extent,
      ),
    ];

    return Tuple2(slivers, offset);
  }
}
