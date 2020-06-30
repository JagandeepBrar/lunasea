import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sabnzbd.dart';

class SABnzbdHistorySearchBar extends StatefulWidget {
    @override
    State<SABnzbdHistorySearchBar> createState() => _State();
}

class _State extends State<SABnzbdHistorySearchBar> {
    final _textController = TextEditingController();
    
    @override
    Widget build(BuildContext context) => Expanded(
        child: Consumer<SABnzbdModel>(
            builder: (context, model, widget) => LSTextInputBar(
                controller: _textController,
                labelText: 'Search History...',
                onChanged: (text, update) => _onChanged(model, text, update),
                margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
            ),
        ),
    );

    void _onChanged(SABnzbdModel model, String text, bool update) {
        model.historySearchFilter = text;
        if(update) _textController.text = '';
    }
}
