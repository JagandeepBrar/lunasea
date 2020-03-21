import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../lidarr.dart';

class LidarrAddSearchBar extends StatefulWidget {
    final Function callback;

    LidarrAddSearchBar({
        @required this.callback,
    });

    @override
    State<LidarrAddSearchBar> createState() => _State();
}

class _State extends State<LidarrAddSearchBar> {
    final TextEditingController _controller = TextEditingController();

    @override
    void initState() {
        super.initState();
        final model = Provider.of<LidarrModel>(context, listen: false);
        _controller.text = model.addSearchQuery;
    }

    @override
    Widget build(BuildContext context) => LSTextInputBar(
        controller: _controller,
        onChanged: (_) => _onChange(),
        onSubmitted: (_) => _onSubmit(),
    );

    void _onChange() {
        final model = Provider.of<LidarrModel>(context, listen: false);
        model?.addSearchQuery = _controller.text;
    }

    void _onSubmit() => widget.callback();
}