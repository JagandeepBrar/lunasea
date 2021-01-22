import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMoviesSearchBar extends StatefulWidget implements PreferredSizeWidget {
    final ScrollController scrollController;

    RadarrMoviesSearchBar({
        Key key,
        @required this.scrollController,
    }) : super(key: key);

    @override
    Size get preferredSize => Size.fromHeight(62.0);

    @override
    State<RadarrMoviesSearchBar> createState() => _State();
}

class _State extends State<RadarrMoviesSearchBar> {
    final TextEditingController _controller = TextEditingController();

    @override
    void initState() {
        super.initState();
        _controller.text = context.read<RadarrState>().moviesSearchQuery;
    }

    @override
    Widget build(BuildContext context) => Padding(
        child: Row(
            children: [
                Expanded(
                    child: Consumer<RadarrState>(
                        builder: (context, state, _) => LSTextInputBar(
                            controller: _controller,
                            autofocus: false,
                            onChanged: (text, updateController) => _onChange(text, updateController),
                            margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 14.0),
                        ),
                    ),
                ),
                RadarrMoviesSearchBarFilterButton(controller: widget.scrollController),
                RadarrMoviesSearchBarSortButton(controller: widget.scrollController),
            ],
        ),
        padding: EdgeInsets.only(top: 1.0, bottom: 1.0),
    );

    void _onChange(String text, bool updateController) {
        context.read<RadarrState>().moviesSearchQuery = text;
        if(updateController) _controller.text = text;
    }
}
