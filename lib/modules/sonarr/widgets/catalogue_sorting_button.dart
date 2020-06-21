import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrCatalogueSortButton extends StatefulWidget {
    final ScrollController controller;

    SonarrCatalogueSortButton({
        Key key,
        @required this.controller,
    }): super(key: key);

    @override
    State<SonarrCatalogueSortButton> createState() => _State();
}

class _State extends State<SonarrCatalogueSortButton> {    
    @override
    Widget build(BuildContext context) => LSCard(
        child: Consumer<SonarrModel>(
            builder: (context, model, widget) => PopupMenuButton<SonarrCatalogueSorting>(
                shape: LunaSeaDatabaseValue.THEME_AMOLED.data && LunaSeaDatabaseValue.THEME_AMOLED_BORDER.data
                    ? LSRoundedShapeWithBorder()
                    : LSRoundedShape(),
                icon: LSIcon(icon: Icons.sort),
                onSelected: (result) {
                    if(model.sortCatalogueType == result) {
                        model.sortCatalogueAscending = !model.sortCatalogueAscending;
                    } else {
                        model.sortCatalogueAscending = true;
                        model.sortCatalogueType = result;
                    }
                    _scrollBack();
                },
                itemBuilder: (context) => List<PopupMenuEntry<SonarrCatalogueSorting>>.generate(
                    SonarrCatalogueSorting.values.length,
                    (index) => PopupMenuItem<SonarrCatalogueSorting>(
                        value: SonarrCatalogueSorting.values[index],
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Text(
                                    SonarrCatalogueSorting.values[index].readable,
                                    style: TextStyle(
                                        fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                                    ),
                                ),
                                if(model.sortCatalogueType == SonarrCatalogueSorting.values[index]) Icon(
                                    model.sortCatalogueAscending
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
