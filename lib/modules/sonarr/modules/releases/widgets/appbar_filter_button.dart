import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrReleasesAppBarFilterButton extends StatefulWidget {
    final ScrollController controller;

    SonarrReleasesAppBarFilterButton({
        Key key,
        @required this.controller,
    }): super(key: key);

    @override
    State<SonarrReleasesAppBarFilterButton> createState() => _State();
}

class _State extends State<SonarrReleasesAppBarFilterButton> {
    @override
    Widget build(BuildContext context) => LSCard(
        child: Consumer<SonarrState>(
            builder: (context, state, widget) => LunaPopupMenuButton<SonarrReleasesFilter>(
                icon: Icons.filter_alt_outlined,
                onSelected: (result) {
                    state.releasesHidingType = result;
                    _scrollBack();
                },
                itemBuilder: (context) => List<PopupMenuEntry<SonarrReleasesFilter>>.generate(
                    SonarrReleasesFilter.values.length,
                    (index) => PopupMenuItem<SonarrReleasesFilter>(
                        value: SonarrReleasesFilter.values[index],
                        child: Text(
                            SonarrReleasesFilter.values[index].readable,
                            style: TextStyle(
                                fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                                color: state.releasesHidingType == SonarrReleasesFilter.values[index]
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