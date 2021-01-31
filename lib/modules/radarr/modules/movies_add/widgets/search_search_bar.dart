import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMoviesAddSearchSearchBar extends StatefulWidget implements PreferredSizeWidget {
    final ScrollController scrollController;

    RadarrMoviesAddSearchSearchBar({
        Key key,
        @required this.scrollController,
    }) : super(key: key);

    @override
    Size get preferredSize => Size.fromHeight(62.0);

    @override
    State<RadarrMoviesAddSearchSearchBar> createState() => _State();
}

class _State extends State<RadarrMoviesAddSearchSearchBar> {
    final TextEditingController _controller = TextEditingController();

    @override
    void initState() {
        super.initState();
        _controller.text = context.read<RadarrState>().addSearchQuery;
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
                            onSubmitted: _onSubmit,
                            margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 14.0),
                        ),
                    ),
                ),
            ],
        ),
        padding: EdgeInsets.only(top: 1.0, bottom: 1.0),
    );

    void _onChange(String text, bool updateController) {
        context.read<RadarrState>().addSearchQuery = text;
        if(updateController) _controller.text = text;
    }

    Future<void> _onSubmit(String value) async {
        if(value.isNotEmpty) context.read<RadarrState>().fetchMoviesLookup();
    }
}
