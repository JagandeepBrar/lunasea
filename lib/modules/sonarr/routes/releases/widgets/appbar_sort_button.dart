import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrReleasesAppBarSortButton extends StatefulWidget {
    final ScrollController controller;

    SonarrReleasesAppBarSortButton({
        Key key,
        @required this.controller,
    }): super(key: key);

    @override
    State<SonarrReleasesAppBarSortButton> createState() => _State();
}

class _State extends State<SonarrReleasesAppBarSortButton> {
    @override
    Widget build(BuildContext context) => LunaCard(
        context: context,
        child: Consumer<SonarrState>(
            builder: (context, state, _) => LunaPopupMenuButton<SonarrReleasesSorting>(
                tooltip: 'Sort Releases',
                icon: Icons.sort,
                onSelected: (result) {
                    if(state.releasesSortType == result) {
                        state.releasesSortAscending = !state.releasesSortAscending;
                    } else {
                        state.releasesSortAscending = true;
                        state.releasesSortType = result;
                    }
                    widget.controller.lunaAnimateToStart();
                },
                itemBuilder: (context) => List<PopupMenuEntry<SonarrReleasesSorting>>.generate(
                    SonarrReleasesSorting.values.length,
                    (index) => PopupMenuItem<SonarrReleasesSorting>(
                        value: SonarrReleasesSorting.values[index],
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Text(
                                    SonarrReleasesSorting.values[index].readable,
                                    style: TextStyle(
                                        fontSize: LunaUI.FONT_SIZE_SUBTITLE,
                                        color: state.releasesSortType == SonarrReleasesSorting.values[index]
                                            ? LunaColours.accent
                                            : Colors.white,
                                    ),
                                ),
                                if(state.releasesSortType == SonarrReleasesSorting.values[index]) Icon(
                                    state.releasesSortAscending
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
        margin: LunaTextInputBar.appBarMargin.subtract(EdgeInsets.only(left: 12.0)),
        color: Theme.of(context).canvasColor,
    );
}