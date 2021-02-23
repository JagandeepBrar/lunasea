import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrCatalogueSearchBarFilterButton extends StatefulWidget {
    final ScrollController controller;

    RadarrCatalogueSearchBarFilterButton({
        Key key,
        @required this.controller,
    }): super(key: key);

    @override
    State<RadarrCatalogueSearchBarFilterButton> createState() => _State();
}

class _State extends State<RadarrCatalogueSearchBarFilterButton> {
    @override
    Widget build(BuildContext context) {
        return LunaCard(
            context: context,
            child: Consumer<RadarrState>(
                builder: (context, state, _) => LunaPopupMenuButton<RadarrMoviesFilter>(
                    tooltip: 'Filter Catalogue',
                    icon: Icons.filter_alt_outlined,
                    onSelected: (result) {
                        state.moviesFilterType = result;
                        widget.controller.lunaAnimateToStart();
                    },
                    itemBuilder: (context) => List<PopupMenuEntry<RadarrMoviesFilter>>.generate(
                        RadarrMoviesFilter.values.length,
                        (index) => PopupMenuItem<RadarrMoviesFilter>(
                            value: RadarrMoviesFilter.values[index],
                            child: Text(
                                RadarrMoviesFilter.values[index].readable,
                                style: TextStyle(
                                    fontSize: LunaUI.FONT_SIZE_SUBTITLE,
                                    color: state.moviesFilterType == RadarrMoviesFilter.values[index] ? LunaColours.accent : Colors.white,
                                ),
                            ),
                        ),
                    ),
                ), 
            ),
            margin: EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 14.0),
            color: Theme.of(context).canvasColor,
        );
    }
}