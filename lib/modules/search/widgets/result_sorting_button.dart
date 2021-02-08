import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search.dart';

class SearchResultsSortButton extends StatefulWidget {
    final ScrollController controller;

    SearchResultsSortButton({
        Key key,
        @required this.controller,
    }): super(key: key);

    @override
    State<SearchResultsSortButton> createState() => _State();
}

class _State extends State<SearchResultsSortButton> {    
    @override
    Widget build(BuildContext context) => LSCard(
        child: Consumer<SearchState>(
            builder: (context, model, widget) => LunaPopupMenuButton<SearchResultsSorting>(
                icon: Icons.sort,
                onSelected: (result) {
                    if(model.sortResultsSorting == result) {
                        model.sortResultsAscending = !model.sortResultsAscending;
                    } else {
                        model.sortResultsAscending = true;
                        model.sortResultsSorting = result;
                    }
                    _scrollBack();
                },
                itemBuilder: (context) => List<PopupMenuEntry<SearchResultsSorting>>.generate(
                    SearchResultsSorting.values.length,
                    (index) => PopupMenuItem<SearchResultsSorting>(
                        value: SearchResultsSorting.values[index],
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Text(
                                    SearchResultsSorting.values[index].readable,
                                    style: TextStyle(
                                        fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                                    ),
                                ),
                                if(model.sortResultsSorting == SearchResultsSorting.values[index]) Icon(
                                    model.sortResultsAscending
                                        ? Icons.arrow_upward
                                        : Icons.arrow_downward,
                                    size: Constants.UI_FONT_SIZE_SUBTITLE+2.0,
                                    color: LunaColours.accent,
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
        if(widget.controller.hasClients) widget.controller.lunaAnimatedToStart();
    }
}
