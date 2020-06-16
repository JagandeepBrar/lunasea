import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

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
    Widget build(BuildContext context) => Expanded(
        child: Consumer<LidarrModel>(
            builder: (context, model, widget) => LSTextInputBar(
                controller: _controller,
                autofocus: true,
                onChanged: (text, updateController) => _onChange(model, text, updateController),
                onSubmitted: (_) => _onSubmit(),
                margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
            ),
        ),
    );

    void _onChange(LidarrModel model, String text, bool updateController) {
        model.addSearchQuery = text;
        if(updateController) _controller.text = text;
    }

    void _onSubmit() => widget.callback();
}