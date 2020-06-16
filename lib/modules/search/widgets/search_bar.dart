import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search.dart';

class SearchSearchBar extends StatefulWidget {
    final Function callback;

    SearchSearchBar({
        @required this.callback,
    });

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SearchSearchBar> {
    final TextEditingController _controller = TextEditingController();

    @override
    void initState() {
        super.initState();
        final model = Provider.of<SearchModel>(context, listen: false);
        _controller.text = model.searchQuery;
    }

    @override
    Widget build(BuildContext context) => Expanded(
        child: Consumer<SearchModel>(
            builder: (context, model, _) => LSTextInputBar(
                controller: _controller,
                onChanged: (text, updateController) => _onChange(model, text, updateController),
                onSubmitted: (_) => _onSubmit(),
                margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
            ),
        ),
    );

    void _onChange(SearchModel model, String text, updateController) {
        model?.searchQuery = text;
        if(updateController) _controller.text = text;
    }

    void _onSubmit() => widget.callback();
}
