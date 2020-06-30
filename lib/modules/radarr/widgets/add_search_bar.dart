import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

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
    Widget build(BuildContext context) => Expanded(
        child: Consumer<RadarrModel>(
            builder: (context, model, widget) => LSTextInputBar(
                controller: _controller,
                autofocus: true,
                onChanged: (text, updateController) => _onChange(model, text, updateController),
                onSubmitted: (_) => _onSubmit(),
                margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
            ),
        ),
    );

    void _onChange(RadarrModel model, String text, updateController) {
        model.addSearchQuery = text;
        if(updateController) _controller.text = text;
    }

    void _onSubmit() => widget.callback();
}
