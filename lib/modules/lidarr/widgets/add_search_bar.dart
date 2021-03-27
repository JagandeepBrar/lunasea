import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrAddSearchBar extends StatefulWidget implements PreferredSizeWidget {
    final Function callback;

    LidarrAddSearchBar({
        Key key,
        @required this.callback,
    }) : super(key: key);

    @override
    Size get preferredSize => Size.fromHeight(62.0);

    @override
    State<LidarrAddSearchBar> createState() => _State();
}

class _State extends State<LidarrAddSearchBar> {
    final TextEditingController _controller = TextEditingController();

    @override
    void initState() {
        super.initState();
        final model = Provider.of<LidarrState>(context, listen: false);
        _controller.text = model.addSearchQuery;
    }

    @override
    Widget build(BuildContext context) {
        return Padding(
            child: Row(
                children: [
                    Expanded(
                        child: Consumer<LidarrState>(
                            builder: (context, state, _) => LunaTextInputBar(
                                controller: _controller,
                                autofocus: true,
                                onChanged: (value) => context.read<LidarrState>().addSearchQuery = value,
                                onSubmitted: (value) {
                                    if(value.isNotEmpty) widget.callback();
                                },
                                margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 14.0),
                            ),
                        ),
                    ),
                ],
            ),
            padding: EdgeInsets.symmetric(vertical: 1.0),
        );
    }
}
