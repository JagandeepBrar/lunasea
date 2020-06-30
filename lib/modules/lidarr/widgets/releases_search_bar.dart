import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrReleasesSearchBar extends StatefulWidget {
    final String prefill;

    LidarrReleasesSearchBar({
        Key key,
        this.prefill = '',
    }): super(key: key);

    @override
    State<LidarrReleasesSearchBar> createState() => _State();
}

class _State extends State<LidarrReleasesSearchBar> {
    final _textController = TextEditingController();

    void initState() {
        super.initState();
        _textController.text = widget.prefill ?? '';
    }
    
    @override
    Widget build(BuildContext context) => Expanded(
        child: Consumer<LidarrModel>(
            builder: (context, model, widget) => LSTextInputBar(
                controller: _textController,
                labelText: 'Search Releases...',
                onChanged: (text, update) => _onChanged(model, text, update),
                margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
            ),
        ),
    );

    void _onChanged(LidarrModel model, String text, bool update) {
        model.searchReleasesFilter = text;
        if(update) _textController.text = '';
    }
}
