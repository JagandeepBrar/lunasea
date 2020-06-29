import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrReleasesSearchBar extends StatefulWidget {
    final String prefill;

    RadarrReleasesSearchBar({
        Key key,
        this.prefill = '',
    }): super(key: key);

    @override
    State<RadarrReleasesSearchBar> createState() => _State();
}

class _State extends State<RadarrReleasesSearchBar> {
    final _textController = TextEditingController();

    void initState() {
        super.initState();
        _textController.text = widget.prefill ?? '';
    }
    
    @override
    Widget build(BuildContext context) => Expanded(
        child: Consumer<RadarrModel>(
            builder: (context, model, widget) => LSTextInputBar(
                controller: _textController,
                labelText: 'Search Releases...',
                onChanged: (text, update) => _onChanged(model, text, update),
                margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
            ),
        ),
    );

    void _onChanged(RadarrModel model, String text, bool update) {
        model.searchReleasesFilter = text;
        if(update) _textController.text = '';
    }
}
