import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesSearchBarSortButton extends StatefulWidget {
    final ScrollController controller;

    SonarrSeriesSearchBarSortButton({
        Key key,
        @required this.controller,
    }): super(key: key);

    @override
    State<SonarrSeriesSearchBarSortButton> createState() => _State();
}

class _State extends State<SonarrSeriesSearchBarSortButton> {
    @override
    Widget build(BuildContext context) => LSCard(
        child: Consumer<SonarrState>(
            builder: (context, state, widget) => PopupMenuButton<SonarrSeriesSorting>(
                shape: LunaDatabaseValue.THEME_AMOLED.data && LunaDatabaseValue.THEME_AMOLED_BORDER.data
                    ? LSRoundedShapeWithBorder()
                    : LSRoundedShape(),
                icon: LSIcon(icon: Icons.sort),
                onSelected: (result) {
                    if(state.seriesSortType == result) {
                        state.seriesSortAscending = !state.seriesSortAscending;
                    } else {
                        state.seriesSortAscending = true;
                        state.seriesSortType = result;
                    }
                    _scrollBack();
                },
                itemBuilder: (context) => List<PopupMenuEntry<SonarrSeriesSorting>>.generate(
                    SonarrSeriesSorting.values.length,
                    (index) => PopupMenuItem<SonarrSeriesSorting>(
                        value: SonarrSeriesSorting.values[index],
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Text(
                                    SonarrSeriesSorting.values[index].readable,
                                    style: TextStyle(
                                        fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                                        color: state.seriesSortType == SonarrSeriesSorting.values[index]
                                            ? LunaColours.accent
                                            : Colors.white,
                                    ),
                                ),
                                if(state.seriesSortType == SonarrSeriesSorting.values[index]) Icon(
                                    state.seriesSortAscending
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