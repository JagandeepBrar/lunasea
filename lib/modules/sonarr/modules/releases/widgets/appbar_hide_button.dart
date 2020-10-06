import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrReleasesAppBarHideButton extends StatefulWidget {
    final ScrollController controller;

    SonarrReleasesAppBarHideButton({
        Key key,
        @required this.controller,
    }): super(key: key);

    @override
    State<SonarrReleasesAppBarHideButton> createState() => _State();
}

class _State extends State<SonarrReleasesAppBarHideButton> {
    @override
    Widget build(BuildContext context) => LSCard(
        child: Consumer<SonarrLocalState>(
            builder: (context, state, widget) => PopupMenuButton<SonarrReleasesHiding>(
                shape: LunaSeaDatabaseValue.THEME_AMOLED.data && LunaSeaDatabaseValue.THEME_AMOLED_BORDER.data
                    ? LSRoundedShapeWithBorder()
                    : LSRoundedShape(),
                icon: LSIcon(icon: Icons.visibility),
                onSelected: (result) {
                    state.releasesHidingType = result;
                    _scrollBack();
                },
                itemBuilder: (context) => List<PopupMenuEntry<SonarrReleasesHiding>>.generate(
                    SonarrReleasesHiding.values.length,
                    (index) => PopupMenuItem<SonarrReleasesHiding>(
                        value: SonarrReleasesHiding.values[index],
                        child: Text(
                            SonarrReleasesHiding.values[index].readable,
                            style: TextStyle(
                                fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                                color: state.releasesHidingType == SonarrReleasesHiding.values[index]
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