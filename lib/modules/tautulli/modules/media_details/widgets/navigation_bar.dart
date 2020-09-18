import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliMediaDetailsNavigationBar extends StatefulWidget {
    static const List<IconData> icons = [
        Icons.info_outline,
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
    int _index = TautulliDatabaseValue.NAVIGATION_INDEX_MEDIA_DETAILS.data;

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
        if(widget.pageController.page.round() == _index) return;
        setState(() => _index = widget.pageController.page.round());
    }

    @override
    Widget build(BuildContext context) => LSBottomNavigationBar(
        index: _index,
        icons: TautulliMediaDetailsNavigationBar.icons,
        titles: TautulliMediaDetailsNavigationBar.titles,
        onTap: _navOnTap,
    );

    Future<void> _navOnTap(int index) async {
        await widget.pageController.animateToPage(
            index,
            duration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
            curve: Curves.easeOutSine,
        );
    }
}
