import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

// ignore: non_constant_identifier_names
Widget SonarrReleasesAppBar({
    @required BuildContext context,
    @required ScrollController scrollController,
}) => LunaAppBar(
    context: context,
    title: 'Releases',
    bottom: _SearchBar(scrollController: scrollController),
    popUntil: '/sonarr',
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
    void initState() {
        super.initState();
        _controller.text = '';
        SchedulerBinding.instance.scheduleFrameCallback((_) {
            Provider.of<SonarrLocalState>(context, listen: false).releasesSearchQuery = '';
        });
    }

    @override
    Widget build(BuildContext context) => Consumer<SonarrLocalState>(
        builder: (context, state, widget) => Row(
            children: [
                Expanded(
                    child: LSTextInputBar(
                        controller: _controller,
                        autofocus: false,
                        onChanged: (text, updateController) => _onChange(state, text, updateController),
                        margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 14.0),
                    ),
                ),
                SonarrReleasesAppBarHideButton(controller: scrollController),
                SonarrReleasesAppBarSortButton(controller: scrollController),
            ],
        ),
    );

    void _onChange(SonarrLocalState state, String text, bool updateController) {
        state.releasesSearchQuery = text;
        if(updateController) _controller.text = text;
    }
}
