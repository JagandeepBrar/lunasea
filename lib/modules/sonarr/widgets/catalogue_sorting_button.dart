import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../sonarr.dart';

class SonarrCatalogueSortButton extends StatefulWidget {
    @override
    State<SonarrCatalogueSortButton> createState() => _State();
}

class _State extends State<SonarrCatalogueSortButton> {    
    @override
    Widget build(BuildContext context) => LSCard(
        child: Padding(
            child: Consumer<SonarrModel>(
                builder: (context, model, widget) => PopupMenuButton<String>(
                    icon: Elements.getIcon(Icons.sort),
                    onSelected: (result) {
                        if(model.sortType == result) {
                            model.sortAscending = !model.sortAscending;
                        } else {
                            model.sortAscending = true;
                            model.sortType = result;
                        }
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
            padding: EdgeInsets.all(1.75),
        ),
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 0.0),
    );
}