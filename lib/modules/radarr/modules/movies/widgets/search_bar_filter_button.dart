import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMoviesSearchBarFilterButton extends StatefulWidget {
    final ScrollController controller;

    RadarrMoviesSearchBarFilterButton({
        Key key,
        @required this.controller,
    }): super(key: key);

    @override
    State<RadarrMoviesSearchBarFilterButton> createState() => _State();
}

class _State extends State<RadarrMoviesSearchBarFilterButton> {
    @override
    Widget build(BuildContext context) => LSCard(
        child: Consumer<RadarrState>(
            builder: (context, state, widget) => PopupMenuButton<RadarrMoviesFilter>(
                shape: LunaDatabaseValue.THEME_AMOLED.data && LunaDatabaseValue.THEME_AMOLED_BORDER.data
                    ? LSRoundedShapeWithBorder()
                    : LSRoundedShape(),
                icon: LSIcon(icon: Icons.filter_alt_outlined),
                onSelected: (result) {
                    state.moviesFilterType = result;
                    _scrollBack();
                },
                itemBuilder: (context) => List<PopupMenuEntry<RadarrMoviesFilter>>.generate(
                    RadarrMoviesFilter.values.length,
                    (index) => PopupMenuItem<RadarrMoviesFilter>(
                        value: RadarrMoviesFilter.values[index],
                        child: Text(
                            RadarrMoviesFilter.values[index].readable,
                            style: TextStyle(
                                fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                                color: state.moviesFilterType == RadarrMoviesFilter.values[index]
                                    ? LunaColours.accent
                                    : Colors.white,
                            ),
                        ),
                    ),
                ),
            ), 
        ),
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 14.0),
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