import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

// ignore: non_constant_identifier_names
Widget TautulliSearchAppBar({
    @required BuildContext context,
}) => LunaAppBar(
    context: context,
    title: 'Search',
    bottom: _SearchBar(),
    popUntil: '/tautulli',
);

class _SearchBar extends StatefulWidget implements PreferredSizeWidget {
    @override
    Size get preferredSize => Size.fromHeight(62.0);

    @override
    State<_SearchBar> createState() => _State();
}

class _State extends State<_SearchBar> {
    final TextEditingController _controller = TextEditingController();

    @override
    void initState() {
        super.initState();
        _controller.text = context.read<TautulliState>().searchQuery;
    }

    @override
    Widget build(BuildContext context) => Container(
        child: Consumer<TautulliState>(
            builder: (context, state, widget) => Row(
                children: [
                    Expanded(
                        child: LSTextInputBar(
                            controller: _controller,
                            autofocus: state.searchQuery.isEmpty,
                            onChanged: (text, updateController) => _onChange(text, updateController),
                            onSubmitted: _onSubmit,
                            margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 14.0),
                        ),
                    ),
                ],
            ),
        ),
    );

    void _onChange(String text, bool updateController) {
        context.read<TautulliState>().searchQuery = text;
        if(updateController) _controller.text = text;
    }

    Future<void> _onSubmit(String value) async {
        if(value.isNotEmpty) context.read<TautulliState>().fetchSearch();
    }
}
