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
    Widget build(BuildContext context) => LunaCard(
        context: context,
        child: Consumer<SonarrState>(
            builder: (context, state, _) => LunaPopupMenuButton<SonarrReleasesFilter>(
                tooltip: 'Filter Releases',
                icon: Icons.filter_alt_outlined,
                onSelected: (result) {
                    state.releasesHidingType = result;
                    widget.controller.lunaAnimateToStart();
                },
                itemBuilder: (context) => List<PopupMenuEntry<SonarrReleasesFilter>>.generate(
                    SonarrReleasesFilter.values.length,
                    (index) => PopupMenuItem<SonarrReleasesFilter>(
                        value: SonarrReleasesFilter.values[index],
                        child: Text(
                            SonarrReleasesFilter.values[index].readable,
                            style: TextStyle(
                                fontSize: LunaUI.FONT_SIZE_SUBTITLE,
                                color: state.releasesHidingType == SonarrReleasesFilter.values[index]
                                    ? LunaColours.accent
                                    : Colors.white,
                            ),
                        ),
                    ),
                ),
            ), 
        ),
        height: LunaTextInputBar.appBarInnerHeight,
        width: LunaTextInputBar.appBarInnerHeight,
        margin: LunaTextInputBar.appBarMargin.subtract(EdgeInsets.only(left: 12.0)),
        color: Theme.of(context).canvasColor,
    );
}