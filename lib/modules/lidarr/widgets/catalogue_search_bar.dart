import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrCatalogueSearchBar extends StatefulWidget {
    @override
    State<LidarrCatalogueSearchBar> createState() => _State();
}

class _State extends State<LidarrCatalogueSearchBar> {
    final _textController = TextEditingController();
    
    @override
    Widget build(BuildContext context) => Expanded(
        child: Consumer<LidarrModel>(
            builder: (context, model, widget) => LSTextInputBar(
                controller: _textController,
                labelText: 'Search Artists...',
                onChanged: (text, update) => _onChanged(model, text, update),
                margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
            ),
        ),
    );

    void _onChanged(LidarrModel model, String text, bool update) {
        model.searchCatalogueFilter = text;
        if(update) _textController.text = '';
    }    
}
