import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/nzbget.dart';

class NZBGetNavigationBar extends StatefulWidget {
    static const List<IconData> icons = [
        CustomIcons.queue,
        CustomIcons.history,
    ];

    static const List<String> titles = [
        'Queue',
        'History',
    ];

    final PageController pageController;

    NZBGetNavigationBar({
        Key key,
        @required this.pageController,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<NZBGetNavigationBar> {
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) {
            Provider.of<NZBGetModel>(context, listen: false).navigationIndex = NZBGetDatabaseValue.NAVIGATION_INDEX.data;
        });
    }

    @override
    Widget build(BuildContext context) => Selector<NZBGetModel, int>(
        selector: (_, model) => model.navigationIndex,
        builder: (context, index, _) => LSBottomNavigationBar(
            index: index,
            icons: NZBGetNavigationBar.icons,
            titles: NZBGetNavigationBar.titles,
            onTap: _navOnTap,
        ),
    );

    Future<void> _navOnTap(int index) async {
        await widget.pageController.animateToPage(
            index,
            duration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
            curve: Curves.easeOutSine,
        );
        Provider.of<NZBGetModel>(context, listen: false).navigationIndex = index;
    }
}
