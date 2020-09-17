import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

// ignore: non_constant_identifier_names
Widget TautulliSearchAppBar() => AppBar(
    title: Text(
        'Search',
        overflow: TextOverflow.fade,
        style: TextStyle(
            fontSize: Constants.UI_FONT_SIZE_HEADER,
        ),
    ),
    centerTitle: false,
    elevation: 0,
    bottom: _SearchBar(),
);

class _SearchBar extends StatefulWidget implements PreferredSizeWidget {
    @override
    Size get preferredSize => Size.fromHeight(60.0);

    @override
    State<_SearchBar> createState() => _State();
}

class _State extends State<_SearchBar> {
    final TextEditingController _controller = TextEditingController();

    @override
    void initState() {
        super.initState();
        _controller.text = Provider.of<TautulliLocalState>(context, listen: false).searchQuery;
    }

    @override
    Widget build(BuildContext context) => Container(
        child: Expanded(
            child: Consumer<TautulliLocalState>(
                builder: (context, state, widget) => LSTextInputBar(
                    controller: _controller,
                    autofocus: state.searchQuery.isEmpty,
                    onChanged: (text, updateController) => _onChange(state, text, updateController),
                    onSubmitted: _onSubmit,
                    margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
                ),
            ),
        ),
    );

    void _onChange(TautulliLocalState state, String text, bool updateController) {
        state.searchQuery = text;
        if(updateController) _controller.text = text;
    }

    Future<void> _onSubmit(String value) async {
        if(value.isNotEmpty) Provider.of<TautulliLocalState>(context, listen: false).fetchSearch(context);
    }
}
