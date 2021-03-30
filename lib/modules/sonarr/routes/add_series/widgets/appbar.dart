import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

// ignore: non_constant_identifier_names
Widget SonarrSeriesAddAppBar({
    @required ScrollController scrollController,
}) => LunaAppBar(
    title: 'Add Series',
    scrollControllers: [scrollController],
    bottom: _SearchBar(scrollController: scrollController),
);

class _SearchBar extends StatefulWidget implements PreferredSizeWidget {
    final ScrollController scrollController;

    _SearchBar({
        Key key,
        @required this.scrollController,
    }) : super(key: key);

    @override
    Size get preferredSize => Size.fromHeight(LunaTextInputBar.appBarHeight);

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
        builder: (context, state, _) => Container(
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                    Expanded(
                        child: LunaTextInputBar(
                            controller: _controller,
                            scrollController: widget.scrollController,
                            autofocus: _controller.text.isEmpty,
                            onChanged: (value) => context.read<SonarrState>().addSearchQuery = value,
                            onSubmitted: _onSubmit,
                            margin: LunaTextInputBar.appBarMargin,
                        ),
                    ),
                ],
            ),
            height: LunaTextInputBar.appBarHeight,
        ),
    );

    Future<void> _onSubmit(String value) async {
        if(value.isNotEmpty) context.read<SonarrState>().fetchSeriesLookup();
    }
}
