import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/mixins/load_callback.dart';
import '../../../../../core/ui.dart';
import '../../../core/adapters/calendar_starting_type.dart';
import '../../../core/state.dart';

class DashboardAppBarSwitchViewAction extends StatefulWidget {
  final PageController? pageController;
  const DashboardAppBarSwitchViewAction({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<DashboardAppBarSwitchViewAction>
    with LunaLoadCallbackMixin {
  bool _showButton = false;

  @override
  Future<void> loadCallback() async {
    _pageControllerListener();
  }

  @override
  void initState() {
    widget.pageController?.addListener(_pageControllerListener);
    super.initState();
  }

  @override
  void dispose() {
    widget.pageController?.removeListener(_pageControllerListener);
    super.dispose();
  }

  void _pageControllerListener() {
    if ((widget.pageController?.page?.round() == 1)) {
      setState(() => _showButton = true);
    } else {
      setState(() => _showButton = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ModuleState, CalendarStartingType>(
      selector: (_, state) => state.calendarStartingType,
      builder: (context, view, _) {
        if (_showButton) {
          return LunaIconButton.appBar(
            icon: view.icon,
            onPressed: () {
              if (view == CalendarStartingType.CALENDAR) {
                context.read<ModuleState>().calendarStartingType =
                    CalendarStartingType.SCHEDULE;
              } else {
                context.read<ModuleState>().calendarStartingType =
                    CalendarStartingType.CALENDAR;
              }
            },
          );
        }
        return Container();
      },
    );
  }
}
