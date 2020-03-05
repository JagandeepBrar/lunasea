import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class LSSearchSearchBar extends StatefulWidget {
    final Function callback;

    LSSearchSearchBar({
        @required this.callback,
    });

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<LSSearchSearchBar> {
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