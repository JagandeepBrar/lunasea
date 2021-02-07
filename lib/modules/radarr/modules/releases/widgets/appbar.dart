import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

// ignore: non_constant_identifier_names
Widget RadarrReleasesAppBar({
    @required BuildContext context,
    @required ScrollController scrollController,
}) => LunaAppBar(
    context: context,
    title: 'Releases',
    bottom: _SearchBar(scrollController: scrollController),
);

class _SearchBar extends StatefulWidget implements PreferredSizeWidget {
    final ScrollController scrollController;

    _SearchBar({
        Key key,
        @required this.scrollController,
    }) : super(key: key);

    @override
    Size get preferredSize => Size.fromHeight(62.0);

    @override
    State<_SearchBar> createState() => _State(scrollController: scrollController);
}

class _State extends State<_SearchBar> {
    final TextEditingController _controller = TextEditingController();
    final ScrollController scrollController;

    _State({ @required this.scrollController });

    @override
    Widget build(BuildContext context) => Consumer<RadarrState>(
        builder: (context, state, widget) => Row(
            children: [
                Expanded(
                    child: LSTextInputBar(
                        controller: _controller,
                        autofocus: false,
                        onChanged: (text, updateController) => _onChange(text, updateController),
                        margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 14.0),
                    ),
                ),
                RadarrReleasesAppBarFilterButton(controller: scrollController),
                RadarrReleasesAppBarSortButton(controller: scrollController),
            ],
        ),
    );

    void _onChange(String text, bool updateController) {
        context.read<RadarrReleasesState>().searchQuery = text;
        if(updateController) _controller.text = text;
    }
}
