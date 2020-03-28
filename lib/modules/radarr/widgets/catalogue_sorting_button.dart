import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../radarr.dart';

class RadarrCatalogueSortButton extends StatefulWidget {
    final ScrollController controller;

    RadarrCatalogueSortButton({
        Key key,
        @required this.controller,
    }): super(key: key);

    @override
    State<RadarrCatalogueSortButton> createState() => _State();
}

class _State extends State<RadarrCatalogueSortButton> {    
    @override
    Widget build(BuildContext context) => LSCard(
        child: Padding(
            child: Consumer<RadarrModel>(
                builder: (context, model, widget) => PopupMenuButton<String>(
                    icon: Elements.getIcon(Icons.sort),
                    onSelected: (result) {
                        if(model.sortType == result) {
                            model.sortAscending = !model.sortAscending;
                        } else {
                            model.sortAscending = true;
                            model.sortType = result;
                        }
                        _onPressed();
                    },
                    itemBuilder: (context) => <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                            value: 'abc',
                            child: Text('Alphabetical'),
                        ),
                        PopupMenuItem<String>(
                            value: 'size',
                            child: Text('Size'),
                        ),
                    ],
                ), 
            ),
            padding: EdgeInsets.all(1.70),
        ),
        color: LSColors.primary,
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 12.0),
    );

    void _onPressed() {
        widget.controller.animateTo(
            1.00,
            duration: Duration(
                milliseconds: Constants.UI_NAVIGATION_SPEED*2,
            ),
            curve: Curves.easeOutSine,
        );
    }
}