import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliUserDetailsNavigationBar extends StatefulWidget {
    static const List<IconData> icons = [
        CustomIcons.user,
        CustomIcons.history,
        Icons.sync,
        Icons.network_check,
    ];

    static const List<String> titles = [
        'Profile',
        'History',
        'Synced Items',
        'IP Addresses',
    ];

    final PageController pageController;

    TautulliUserDetailsNavigationBar({
        Key key,
        @required this.pageController,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<TautulliUserDetailsNavigationBar> {
    @override
    Widget build(BuildContext context) => Selector<TautulliState, int>(
        selector: (_, state) => state.userDetailsNavigationIndex,
        builder: (context, index, _) => LSBottomNavigationBar(
            index: index,
            icons: TautulliUserDetailsNavigationBar.icons,
            titles: TautulliUserDetailsNavigationBar.titles,
            onTap: _navOnTap,
        ),
    );

    Future<void> _navOnTap(int index) async {
        await widget.pageController.animateToPage(
            index,
            duration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
            curve: Curves.easeOutSine,
        );
        Provider.of<TautulliState>(context, listen: false).userDetailsNavigationIndex = index;
    }
}