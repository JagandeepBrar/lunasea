import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/dashboard.dart';

class DashboardAppBarSwitchViewAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<DashboardState, CalendarStartingType>(
      selector: (_, state) => state.calendarStartingType,
      builder: (context, view, _) => LunaIconButton(
        icon: view.icon,
        onPressed: () {
          view == CalendarStartingType.CALENDAR
              ? context.read<DashboardState>().calendarStartingType =
                  CalendarStartingType.SCHEDULE
              : context.read<DashboardState>().calendarStartingType =
                  CalendarStartingType.CALENDAR;
        },
      ),
    );
  }
}
