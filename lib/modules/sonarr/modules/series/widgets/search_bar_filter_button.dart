import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesSearchBarFilterButton extends StatefulWidget {
    final ScrollController controller;

    SonarrSeriesSearchBarFilterButton({
        Key key,
        @required this.controller,
    }): super(key: key);

    @override
    State<SonarrSeriesSearchBarFilterButton> createState() => _State();
}

class _State extends State<SonarrSeriesSearchBarFilterButton> {
    @override
    Widget build(BuildContext context) => LSCard(
        child: Consumer<SonarrState>(
            builder: (context, state, _) => LunaPopupMenuButton<SonarrSeriesFilter>(
                icon: Icons.filter_alt_outlined,
                onSelected: (result) {
                    state.seriesHidingType = result;
                    widget.controller.lunaAnimateToStart();
                },
                itemBuilder: (context) => List<PopupMenuEntry<SonarrSeriesFilter>>.generate(
                    SonarrSeriesFilter.values.length,
                    (index) => PopupMenuItem<SonarrSeriesFilter>(
                        value: SonarrSeriesFilter.values[index],
                        child: Text(
                            SonarrSeriesFilter.values[index].readable,
                            style: TextStyle(
                                fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                                color: state.seriesHidingType == SonarrSeriesFilter.values[index]
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
}