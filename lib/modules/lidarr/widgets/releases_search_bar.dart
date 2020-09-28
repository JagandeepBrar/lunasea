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
        child: Consumer<LidarrState>(
            builder: (context, state, widget) => LSTextInputBar(
                controller: _textController,
                labelText: 'Search Releases...',
                onChanged: (text, update) => _onChanged(state, text, update),
                margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
            ),
        ),
    );

    void _onChanged(LidarrState state, String text, bool update) {
        state.searchReleasesFilter = text;
        if(update) _textController.text = '';
    }
}
