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
    Widget build(BuildContext context) => LunaCard(
        context: context,
        child: Consumer<SonarrState>(
            builder: (context, state, _) => LunaPopupMenuButton<SonarrSeriesSorting>(
                tooltip: 'Sort Catalogue',
                icon: Icons.sort,
                onSelected: (result) {
                    if(state.seriesSortType == result) {
                        state.seriesSortAscending = !state.seriesSortAscending;
                    } else {
                        state.seriesSortAscending = true;
                        state.seriesSortType = result;
                    }
                    widget.controller.lunaAnimateToStart();
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
                                        fontSize: LunaUI.FONT_SIZE_SUBTITLE,
                                        color: state.seriesSortType == SonarrSeriesSorting.values[index]
                                            ? LunaColours.accent
                                            : Colors.white,
                                    ),
                                ),
                                if(state.seriesSortType == SonarrSeriesSorting.values[index]) FaIcon(
                                    state.seriesSortAscending
                                        ? Icons.arrow_upward
                                        : Icons.arrow_downward,
                                    size: LunaUI.FONT_SIZE_SUBTITLE+2.0,
                                    color: LunaColours.accent,
                                ),
                            ],
                        ),
                    ),
                ),
            ), 
        ),
        height: LunaTextInputBar.appBarInnerHeight,
        width: LunaTextInputBar.appBarInnerHeight,
        margin: EdgeInsets.zero,
        color: Theme.of(context).canvasColor,
    );
}