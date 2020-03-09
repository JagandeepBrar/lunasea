import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

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
        onChanged: (_) => _onChange(),
        onSubmitted: (_) => _onSubmit(),
    );

    void _onChange() {
        final model = Provider.of<SearchModel>(context, listen: false);
        model?.searchQuery = _controller.text;
    }

    void _onSubmit() => widget.callback();
}