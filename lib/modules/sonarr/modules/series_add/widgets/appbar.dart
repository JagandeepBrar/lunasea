import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

// ignore: non_constant_identifier_names
Widget SonarrSeriesAddAppBar({
    @required BuildContext context,
    List<Widget> actions,
}) => LunaAppBar(
    context: context,
    title: 'Add Series',
    actions: actions,
    bottom: _SearchBar(),
    popUntil: '/sonarr',
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
        _controller.text = Provider.of<SonarrLocalState>(context, listen: false).addSearchQuery;
    }

    Future<void> _execute() async {
        //TODO
    }

    @override
    Widget build(BuildContext context) => Consumer<SonarrLocalState>(
        builder: (context, state, widget) => Row(
            children: [
                Expanded(
                    child: LSTextInputBar(
                        controller: _controller,
                        autofocus: _controller.text.isEmpty,
                        onChanged: (text, updateController) => _onChange(state, text, updateController),
                        onSubmitted: (_) async => _execute(),
                        margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 14.0),
                    ),
                ),
            ],
        ),
    );

    void _onChange(SonarrLocalState state, String text, bool updateController) {
        state.addSearchQuery = text;
        if(updateController) _controller.text = text;
    }
}
