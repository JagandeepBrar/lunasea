import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliMediaDetailsNavigationBar extends StatefulWidget {
    static const List<IconData> icons = [
        Icons.video_library,
        CustomIcons.history,
    ];

    static const List<String> titles = [
        'Metadata',
        'History',
    ];

    final PageController pageController;

    TautulliMediaDetailsNavigationBar({
        Key key,
        @required this.pageController,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<TautulliMediaDetailsNavigationBar> {
    @override
    Widget build(BuildContext context) => Selector<TautulliLocalState, int>(
        selector: (_, state) => state.mediaNavigationIndex,
        builder: (context, index, _) => LSBottomNavigationBar(
            index: index,
            icons: TautulliMediaDetailsNavigationBar.icons,
            titles: TautulliMediaDetailsNavigationBar.titles,
            onTap: _navOnTap,
        ),
    );

    Future<void> _navOnTap(int index) async {
        await widget.pageController.animateToPage(
            index,
            duration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
            curve: Curves.easeOutSine,
        );
        Provider.of<TautulliLocalState>(context, listen: false).mediaNavigationIndex = index;
    }
}