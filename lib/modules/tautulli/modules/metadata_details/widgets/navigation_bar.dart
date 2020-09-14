import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliMetadataNavigationBar extends StatefulWidget {
    static const List<IconData> icons = [
        Icons.video_library,
        CustomIcons.history,
    ];

    static const List<String> titles = [
        'Metadata',
        'History',
    ];

    final PageController pageController;

    TautulliMetadataNavigationBar({
        Key key,
        @required this.pageController,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<TautulliMetadataNavigationBar> {
    @override
    Widget build(BuildContext context) => Selector<TautulliLocalState, int>(
        selector: (_, state) => state.metadataNavigationIndex,
        builder: (context, index, _) => LSBottomNavigationBar(
            index: index,
            icons: TautulliMetadataNavigationBar.icons,
            titles: TautulliMetadataNavigationBar.titles,
            onTap: _navOnTap,
        ),
    );

    Future<void> _navOnTap(int index) async {
        await widget.pageController.animateToPage(
            index,
            duration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
            curve: Curves.easeOutSine,
        );
        Provider.of<TautulliLocalState>(context, listen: false).metadataNavigationIndex = index;
    }
}