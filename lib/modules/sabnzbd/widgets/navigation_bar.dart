import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../sabnzbd.dart';

class SABnzbdNavigationBar extends StatefulWidget {
    final PageController pageController;

    SABnzbdNavigationBar({
        Key key,
        @required this.pageController,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SABnzbdNavigationBar> {
    static const List<IconData> _navbarIcons = [
        CustomIcons.queue,
        CustomIcons.history,
    ];

    static const List<String> _navbarTitles = [
        'Queue',
        'History',
    ];

    @override
    Widget build(BuildContext context) => Selector<SABnzbdModel, int>(
        selector: (_, model) => model.navigationIndex,
        builder: (context, index, _) => LSBottomNavigationBar(
            index: index,
            icons: _navbarIcons,
            titles: _navbarTitles,
            onTap: _navOnTap,
        ),
    );

    Future<void> _navOnTap(int index) async {
        await widget.pageController.animateToPage(
            index,
            duration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
            curve: Curves.easeOutSine,
        );
        Provider.of<SABnzbdModel>(context, listen: false).navigationIndex = index;
    }
}
