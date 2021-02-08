import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sabnzbd.dart';

class SABnzbdNavigationBar extends StatefulWidget {
    static const List<IconData> icons = [
        CustomIcons.queue,
        CustomIcons.history,
    ];

    static const List<String> titles = [
        'Queue',
        'History',
    ];

    final PageController pageController;

    SABnzbdNavigationBar({
        Key key,
        @required this.pageController,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SABnzbdNavigationBar> {
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) {
            Provider.of<SABnzbdState>(context, listen: false).navigationIndex = SABnzbdDatabaseValue.NAVIGATION_INDEX.data;
        });
    }

    @override
    Widget build(BuildContext context) => Selector<SABnzbdState, int>(
        selector: (_, model) => model.navigationIndex,
        builder: (context, index, _) => LSBottomNavigationBar(
            index: index,
            icons: SABnzbdNavigationBar.icons,
            titles: SABnzbdNavigationBar.titles,
            onTap: _navOnTap,
        ),
    );

    Future<void> _navOnTap(int index) async {
        widget.pageController.lunaAnimateToPage(index)
        .then((_) => Provider.of<SABnzbdState>(context, listen: false).navigationIndex = index);
    }
}
