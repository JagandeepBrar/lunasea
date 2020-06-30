import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search.dart';

class SearchResultsSearchBar extends StatefulWidget {
    final String prefill;

    SearchResultsSearchBar({
        Key key,
        this.prefill = '',
    }): super(key: key);

    @override
    State<SearchResultsSearchBar> createState() => _State();
}

class _State extends State<SearchResultsSearchBar> {
    final _textController = TextEditingController();

    void initState() {
        super.initState();
        _textController.text = widget.prefill ?? '';
    }
    
    @override
    Widget build(BuildContext context) => Expanded(
        child: Consumer<SearchModel>(
            builder: (context, model, widget) => LSTextInputBar(
                controller: _textController,
                labelText: 'Search Results...',
                onChanged: (text, update) => _onChanged(model, text, update),
                margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
            ),
        ),
    );

    void _onChanged(SearchModel model, String text, bool update) {
        model.searchResultsFilter = text;
        if(update) _textController.text = '';
    }
}
