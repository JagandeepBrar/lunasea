import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrReleasesAppBarFilterButton extends StatefulWidget {
    final ScrollController controller;

    RadarrReleasesAppBarFilterButton({
        Key key,
        @required this.controller,
    }): super(key: key);

    @override
    State<RadarrReleasesAppBarFilterButton> createState() => _State();
}

class _State extends State<RadarrReleasesAppBarFilterButton> {
    @override
    Widget build(BuildContext context) => LSCard(
        child: Consumer<RadarrReleasesState>(
            builder: (context, state, widget) => LunaPopupMenuButton<RadarrReleasesFilter>(
                icon: Icons.filter_alt_outlined,
                onSelected: (result) {
                    state.filterType = result;
                    _scrollBack();
                },
                itemBuilder: (context) => List<PopupMenuEntry<RadarrReleasesFilter>>.generate(
                    RadarrReleasesFilter.values.length,
                    (index) => PopupMenuItem<RadarrReleasesFilter>(
                        value: RadarrReleasesFilter.values[index],
                        child: Text(
                            RadarrReleasesFilter.values[index].readable,
                            style: TextStyle(
                                fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                                color: state.filterType == RadarrReleasesFilter.values[index]
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
        if(widget.controller.hasClients) widget.controller.lunaAnimatedToStart();
    }
}
