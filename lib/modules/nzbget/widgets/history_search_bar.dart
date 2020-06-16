import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/nzbget.dart';

class NZBGetHistorySearchBar extends StatefulWidget {
    @override
    State<NZBGetHistorySearchBar> createState() => _State();
}

class _State extends State<NZBGetHistorySearchBar> {
    final _textController = TextEditingController();
    
    @override
    Widget build(BuildContext context) => Expanded(
        child: Consumer<NZBGetModel>(
            builder: (context, model, widget) => LSTextInputBar(
                controller: _textController,
                labelText: 'Search History...',
                onChanged: (text, update) => _onChanged(model, text, update),
                margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
            ),
        ),
    );

    void _onChanged(NZBGetModel model, String text, bool update) {
        model.historySearchFilter = text;
        if(update) _textController.text = '';
    }
}
