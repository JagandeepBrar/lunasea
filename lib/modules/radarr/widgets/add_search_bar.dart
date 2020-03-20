import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';
import '../../radarr.dart';

class RadarrAddSearchBar extends StatefulWidget {
    final Function callback;

    RadarrAddSearchBar({
        @required this.callback,
    });

    @override
    State<RadarrAddSearchBar> createState() => _State();
}

class _State extends State<RadarrAddSearchBar> {
    final TextEditingController _controller = TextEditingController();

    @override
    void initState() {
        super.initState();
        final model = Provider.of<RadarrModel>(context, listen: false);
        _controller.text = model.addSearchQuery;
    }

    @override
    Widget build(BuildContext context) => LSTextInputBar(
        controller: _controller,
        onChanged: (_) => _onChange(),
        onSubmitted: (_) => _onSubmit(),
    );

    void _onChange() {
        final model = Provider.of<RadarrModel>(context, listen: false);
        model?.addSearchQuery = _controller.text;
    }

    void _onSubmit() => widget.callback();
}