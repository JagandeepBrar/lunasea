import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesSearchBarHideButton extends StatefulWidget {
    final ScrollController controller;

    SonarrSeriesSearchBarHideButton({
        Key key,
        @required this.controller,
    }): super(key: key);

    @override
    State<SonarrSeriesSearchBarHideButton> createState() => _State();
}

class _State extends State<SonarrSeriesSearchBarHideButton> {
    @override
    Widget build(BuildContext context) => LSCard(
        child: Consumer<SonarrState>(
            builder: (context, state, widget) => PopupMenuButton<SonarrSeriesHiding>(
                shape: LunaSeaDatabaseValue.THEME_AMOLED.data && LunaSeaDatabaseValue.THEME_AMOLED_BORDER.data
                    ? LSRoundedShapeWithBorder()
                    : LSRoundedShape(),
                icon: LSIcon(icon: Icons.visibility),
                onSelected: (result) {
                    state.seriesHidingType = result;
                    _scrollBack();
                },
                itemBuilder: (context) => List<PopupMenuEntry<SonarrSeriesHiding>>.generate(
                    SonarrSeriesHiding.values.length,
                    (index) => PopupMenuItem<SonarrSeriesHiding>(
                        value: SonarrSeriesHiding.values[index],
                        child: Text(
                            SonarrSeriesHiding.values[index].readable,
                            style: TextStyle(
                                fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                                color: state.seriesHidingType == SonarrSeriesHiding.values[index]
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