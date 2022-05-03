import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../ui/ui.dart';
import '../../../../../vendor.dart';
import '../../../core/adapters/calendar_starting_type.dart';
import '../../../core/state.dart';

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
    return Selector<ModuleState, CalendarStartingType>(
      selector: (_, state) => state.calendarStartingType,
      builder: (context, view, _) {
        if (_showButton) {
          return LunaIconButton.appBar(
            icon: view.icon,
            onPressed: () {
              final state = context.read<ModuleState>();
              if (view == CalendarStartingType.CALENDAR)
                state.calendarStartingType = CalendarStartingType.SCHEDULE;
              else
                state.calendarStartingType = CalendarStartingType.CALENDAR;
            },
          );
        }
        return Container();
      },
    );
  }
}
