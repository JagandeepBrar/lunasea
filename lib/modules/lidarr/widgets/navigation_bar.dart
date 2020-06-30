import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrNavigationBar extends StatefulWidget {
    static const List<IconData> icons = [
        CustomIcons.music,
        CustomIcons.calendar_missing,
        CustomIcons.history,
    ];

    static const List<String> titles = [
        'Catalogue',
        'Missing',
        'History',
    ];

    final PageController pageController;

    LidarrNavigationBar({
        Key key,
        @required this.pageController,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<LidarrNavigationBar> {
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) {
            Provider.of<LidarrModel>(context, listen: false).navigationIndex = LidarrDatabaseValue.NAVIGATION_INDEX.data;
        });
    }

    @override
    Widget build(BuildContext context) => Selector<LidarrModel, int>(
        selector: (_, model) => model.navigationIndex,
        builder: (context, index, _) => LSBottomNavigationBar(
            index: index,
            icons: LidarrNavigationBar.icons,
            titles: LidarrNavigationBar.titles,
            onTap: _navOnTap,
        ),
    );

    Future<void> _navOnTap(int index) async {
        await widget.pageController.animateToPage(
            index,
            duration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
            curve: Curves.easeOutSine,
        );
        Provider.of<LidarrModel>(context, listen: false).navigationIndex = index;
    }
}