import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search.dart';

class SearchSearchBar extends StatefulWidget implements PreferredSizeWidget {
    final Function(String) submitCallback;

    SearchSearchBar({
        Key key,
        @required this.submitCallback,
    }) : super(key: key);

    @override
    Size get preferredSize => Size.fromHeight(62.0);

    @override
    State<SearchSearchBar> createState() => _State();
}

class _State extends State<SearchSearchBar> {
    final TextEditingController _controller = TextEditingController();

    @override
    Widget build(BuildContext context) {
        return Row(
            children: [
                Expanded(
                    child: Consumer<SearchState>(
                        builder: (context, state, _) => LunaTextInputBar(
                            controller: _controller,
                            autofocus: true,
                            onChanged: (value) => context.read<SearchState>().searchQuery = value,
                            onSubmitted: widget.submitCallback,
                            margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 14.0),
                        ),
                    ),
                ),
            ],
        );
    }
}
