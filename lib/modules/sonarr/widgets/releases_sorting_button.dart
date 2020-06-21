import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrReleasesSortButton extends StatefulWidget {
    final ScrollController controller;

    SonarrReleasesSortButton({
        Key key,
        @required this.controller,
    }): super(key: key);

    @override
    State<SonarrReleasesSortButton> createState() => _State();
}

class _State extends State<SonarrReleasesSortButton> {    
    @override
    Widget build(BuildContext context) => LSCard(
        child: Consumer<SonarrModel>(
            builder: (context, model, widget) => PopupMenuButton<SonarrReleasesSorting>(
                shape: LunaSeaDatabaseValue.THEME_AMOLED.data && LunaSeaDatabaseValue.THEME_AMOLED_BORDER.data
                    ? LSRoundedShapeWithBorder()
                    : LSRoundedShape(),
                icon: LSIcon(icon: Icons.sort),
                onSelected: (result) {
                    if(model.sortReleasesType == result) {
                        model.sortReleasesAscending = !model.sortReleasesAscending;
                    } else {
                        model.sortReleasesAscending = true;
                        model.sortReleasesType = result;
                    }
                    _scrollBack();
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
                                        fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                                    ),
                                ),
                                if(model.sortReleasesType == SonarrReleasesSorting.values[index]) Icon(
                                    model.sortReleasesAscending
                                        ? Icons.arrow_upward
                                        : Icons.arrow_downward,
                                    size: Constants.UI_FONT_SIZE_SUBTITLE+2.0,
                                    color: LSColors.accent,
                                ),
                            ],
                        ),
                    ),
                ),
            ), 
        ),
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 12.0),
        color: Theme.of(context).canvasColor,
    );

    void _scrollBack() {
        widget.controller.animateTo(
            1.00,
            duration: Duration(
                milliseconds: Constants.UI_NAVIGATION_SPEED*2,
            ),
            curve: Curves.easeOutSine,
        );
    }
}
