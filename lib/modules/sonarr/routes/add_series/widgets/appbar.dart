import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

// ignore: non_constant_identifier_names
Widget SonarrSeriesAddAppBar() => LunaAppBar(
    title: 'Add Series',
    bottom: _SearchBar(),
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
        _controller.text = context.read<SonarrState>().addSearchQuery;
    }

    @override
    Widget build(BuildContext context) => Consumer<SonarrState>(
        builder: (context, state, widget) => Row(
            children: [
                Expanded(
                    child: LSTextInputBar(
                        controller: _controller,
                        autofocus: _controller.text.isEmpty,
                        onChanged: (text, updateController) => _onChange(text, updateController),
                        onSubmitted: _onSubmit,
                        margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 14.0),
                    ),
                ),
            ],
        ),
    );

    void _onChange(String text, bool updateController) {
        context.read<SonarrState>().addSearchQuery = text;
        if(updateController) _controller.text = text;
    }

    Future<void> _onSubmit(String value) async {
        if(value.isNotEmpty) context.read<SonarrState>().fetchSeriesLookup();
    }
}
