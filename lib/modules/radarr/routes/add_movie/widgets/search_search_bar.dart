import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAddMovieSearchSearchBar extends StatefulWidget implements PreferredSizeWidget {
    final String query;

    RadarrAddMovieSearchSearchBar({
        Key key,
        @required this.query,
    }) : super(key: key);

    @override
    Size get preferredSize => Size.fromHeight(62.0);

    @override
    State<RadarrAddMovieSearchSearchBar> createState() => _State();
}

class _State extends State<RadarrAddMovieSearchSearchBar> {
    TextEditingController _controller;

    @override
    void initState() {
        super.initState();
        _controller = TextEditingController(text: widget.query);
    }

    @override
    Widget build(BuildContext context) {
        return Padding(
            child: Row(
                children: [
                    Expanded(
                        child: Consumer<RadarrAddMovieState>(
                            builder: (context, state, _) => LunaTextInputBar(
                                controller: _controller,
                                autofocus: context.read<RadarrAddMovieState>().searchQuery?.isEmpty ?? true,
                                onChanged: (value) => context.read<RadarrAddMovieState>().searchQuery = value,
                                onSubmitted: (value) {
                                    if(value.isNotEmpty) context.read<RadarrAddMovieState>().fetchLookup(context);
                                },
                                margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 14.0),
                            ),
                        ),
                    ),
                ],
            ),
            padding: EdgeInsets.only(top: 1.0, bottom: 1.0),
        );
    }
}
