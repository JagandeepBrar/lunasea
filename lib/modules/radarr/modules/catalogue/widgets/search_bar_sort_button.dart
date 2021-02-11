import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrCatalogueSearchBarSortButton extends StatefulWidget {
    final ScrollController controller;

    RadarrCatalogueSearchBarSortButton({
        Key key,
        @required this.controller,
    }): super(key: key);

    @override
    State<RadarrCatalogueSearchBarSortButton> createState() => _State();
}

class _State extends State<RadarrCatalogueSearchBarSortButton> {
    @override
    Widget build(BuildContext context) => LunaCard(
        context: context,
        child: Consumer<RadarrState>(
            builder: (context, state, _) => LunaPopupMenuButton<RadarrMoviesSorting>(
                icon: Icons.sort,
                onSelected: (result) {
                    if(state.moviesSortType == result) {
                        state.moviesSortAscending = !state.moviesSortAscending;
                    } else {
                        state.moviesSortAscending = true;
                        state.moviesSortType = result;
                    }
                    widget.controller.lunaAnimateToStart();
                },
                itemBuilder: (context) => List<PopupMenuEntry<RadarrMoviesSorting>>.generate(
                    RadarrMoviesSorting.values.length,
                    (index) => PopupMenuItem<RadarrMoviesSorting>(
                        value: RadarrMoviesSorting.values[index],
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Text(
                                    RadarrMoviesSorting.values[index].readable,
                                    style: TextStyle(
                                        fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                                        color: state.moviesSortType == RadarrMoviesSorting.values[index] ? LunaColours.accent : Colors.white,
                                    ),
                                ),
                                if(state.moviesSortType == RadarrMoviesSorting.values[index]) Icon(
                                    state.moviesSortAscending ? Icons.arrow_upward : Icons.arrow_downward,
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
}