import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../search.dart';

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
    Widget build(BuildContext context) => LSTextInputBar(
        controller: _controller,
        onChanged: (text, updateController) => _onChange(text, updateController),
        onSubmitted: (_) => _onSubmit(),
    );

    void _onChange(String text, updateController) {
        final model = Provider.of<SearchModel>(context, listen: false);
        model?.searchQuery = text;
        if(updateController) _controller.text = text;
    }

    void _onSubmit() => widget.callback();
}