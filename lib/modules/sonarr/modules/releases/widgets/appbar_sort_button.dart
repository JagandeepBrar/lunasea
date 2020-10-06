import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrReleasesAppBarSortButton extends StatefulWidget {
    final ScrollController controller;

    SonarrReleasesAppBarSortButton({
        Key key,
        @required this.controller,
    }): super(key: key);

    @override
    State<SonarrReleasesAppBarSortButton> createState() => _State();
}

class _State extends State<SonarrReleasesAppBarSortButton> {
    @override
    Widget build(BuildContext context) => LSCard(
        child: Consumer<SonarrLocalState>(
            builder: (context, state, widget) => PopupMenuButton<SonarrReleasesSorting>(
                shape: LunaSeaDatabaseValue.THEME_AMOLED.data && LunaSeaDatabaseValue.THEME_AMOLED_BORDER.data
                    ? LSRoundedShapeWithBorder()
                    : LSRoundedShape(),
                icon: LSIcon(icon: Icons.sort),
                onSelected: (result) {
                    if(state.releasesSortType == result) {
                        state.releasesSortAscending = !state.releasesSortAscending;
                    } else {
                        state.releasesSortAscending = true;
                        state.releasesSortType = result;
                    }
                    _scrollBack();
                },
                itemBuilder: (context) => List<PopupMenuEntry<SonarrReleasesSorting>>.generate(
                    SonarrReleasesSorting.values.length,
                    (index) => PopupMenuItem<SonarrReleasesSorting>(
                        value: SonarrReleasesSorting.values[index],
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Text(
                                    SonarrReleasesSorting.values[index].readable,
                                    style: TextStyle(
                                        fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                                        color: state.releasesSortType == SonarrReleasesSorting.values[index]
                                            ? LunaColours.accent
                                            : Colors.white,
                                    ),
                                ),
                                if(state.releasesSortType == SonarrReleasesSorting.values[index]) Icon(
                                    state.releasesSortAscending
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
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 12.0),
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