import 'package:flutter/material.dart';

import 'package:lunasea/widgets/ui.dart';
import 'package:lunasea/vendor.dart';
import 'package:lunasea/modules/dashboard/core/adapters/calendar_starting_type.dart';
import 'package:lunasea/modules/dashboard/core/state.dart';

class SwitchViewAction extends StatefulWidget {
  final PageController? pageController;
  const SwitchViewAction({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SwitchViewAction> with LunaLoadCallbackMixin {
  bool _showButton = false;

  @override
  Future<void> loadCallback() async {
    _pageControllerListener();
  }

  @override
  void initState() {
    super.initState();
    widget.pageController?.addListener(_pageControllerListener);
  }

  @override
  void dispose() {
    widget.pageController?.removeListener(_pageControllerListener);
    super.dispose();
  }

  void _pageControllerListener() {
    int? page = widget.pageController?.page?.round();
    setState(() => _showButton = page == 1);
  }

  @override
  Widget build(BuildContext context) {
    return Selector<DashboardState, CalendarStartingType>(
      selector: (_, state) => state.calendarType,
      builder: (context, view, _) {
        if (_showButton) {
          return LunaIconButton.appBar(
            icon: view.icon,
            onPressed: () {
              final state = context.read<DashboardState>();
              if (view == CalendarStartingType.CALENDAR)
                state.calendarType = CalendarStartingType.SCHEDULE;
              else
                state.calendarType = CalendarStartingType.CALENDAR;
            },
          );
        }
        return Container();
      },
    );
  }
}
