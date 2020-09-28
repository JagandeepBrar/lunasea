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
        child: Consumer<LidarrState>(
            builder: (context, state, widget) => LSTextInputBar(
                controller: _textController,
                labelText: 'Search Artists...',
                onChanged: (text, update) => _onChanged(state, text, update),
                margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
            ),
        ),
    );

    void _onChanged(LidarrState state, String text, bool update) {
        state.searchCatalogueFilter = text;
        if(update) _textController.text = '';
    }    
}
