import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../nzbget.dart';

class NZBGetNavigationBar extends StatefulWidget {
    final PageController pageController;

    NZBGetNavigationBar({
        Key key,
        @required this.pageController,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<NZBGetNavigationBar> {
    static const List<Icon> _navbarIcons = [
        Icon(CustomIcons.queue),
        Icon(CustomIcons.history)
    ];

    static const List<String> _navbarTitles = [
        'Queue',
        'History',
    ];

    @override
    Widget build(BuildContext context) => Selector<NZBGetModel, int>(
        selector: (_, model) => model.navigationIndex,
        builder: (context, index, _) => LSBottomNavigationBar(
            index: index,
            icons: _navbarIcons,
            titles: _navbarTitles,
            onTap: _navOnTap,
        ),
    );

    void _navOnTap(int index) {
        widget.pageController.jumpToPage(index);
        Provider.of<NZBGetModel>(context, listen: false).navigationIndex = index;
    }
}
