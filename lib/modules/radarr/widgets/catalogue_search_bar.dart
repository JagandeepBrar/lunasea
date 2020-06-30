import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrCatalogueSearchBar extends StatefulWidget {
    @override
    State<RadarrCatalogueSearchBar> createState() => _State();
}

class _State extends State<RadarrCatalogueSearchBar> {
    final _textController = TextEditingController();
    
    @override
    Widget build(BuildContext context) => Expanded(
        child: Consumer<RadarrModel>(
            builder: (context, model, widget) => LSTextInputBar(
                controller: _textController,
                labelText: 'Search Movies...',
                onChanged: (text, update) => _onChanged(model, text, update),
                margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
            ),
        ),
    );

    void _onChanged(RadarrModel model, String text, bool update) {
        model.searchCatalogueFilter = text;
        if(update) _textController.text = '';
    }
}