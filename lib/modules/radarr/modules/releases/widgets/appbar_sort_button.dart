import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrReleasesAppBarSortButton extends StatefulWidget {
    final ScrollController controller;

    RadarrReleasesAppBarSortButton({
        Key key,
        @required this.controller,
    }): super(key: key);

    @override
    State<RadarrReleasesAppBarSortButton> createState() => _State();
}

class _State extends State<RadarrReleasesAppBarSortButton> {
    @override
    Widget build(BuildContext context) => LSCard(
        child: Consumer<RadarrReleasesState>(
            builder: (context, state, widget) => LunaPopupMenuButton<RadarrReleasesSorting>(
                icon: Icons.sort,
                onSelected: (result) {
                    if(state.sortType == result) {
                        state.sortAscending = !state.sortAscending;
                    } else {
                        state.sortAscending = true;
                        state.sortType = result;
                    }
                    _scrollBack();
                },
                itemBuilder: (context) => List<PopupMenuEntry<RadarrReleasesSorting>>.generate(
                    RadarrReleasesSorting.values.length,
                    (index) => PopupMenuItem<RadarrReleasesSorting>(
                        value: RadarrReleasesSorting.values[index],
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Text(
                                    RadarrReleasesSorting.values[index].readable,
                                    style: TextStyle(
                                        fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                                        color: state.sortType == RadarrReleasesSorting.values[index]
                                            ? LunaColours.accent
                                            : Colors.white,
                                    ),
                                ),
                                if(state.sortType == RadarrReleasesSorting.values[index]) Icon(
                                    state.sortAscending
                                        ? Icons.arrow_upward
                                        : Icons.arrow_downward,
                                    size: Constants.UI_FONT_SIZE_SUBTITLE+2.0,
                                    color: LunaColours.accent,
                                ),
                            ],
                        ),
                    ),
                ),
            ), 
        ),
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 13.5),
        color: Theme.of(context).canvasColor,
    );

    void _scrollBack() {
        if(widget.controller.hasClients) widget.controller.animateTo(
            1.00,
            duration: Duration(
                milliseconds: Constants.UI_NAVIGATION_SPEED*2,
            ),
            curve: Curves.easeOutSine,
        );
    }
}