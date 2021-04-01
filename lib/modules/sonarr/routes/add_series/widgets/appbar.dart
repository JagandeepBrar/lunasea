import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

// ignore: non_constant_identifier_names
Widget SonarrSeriesAddAppBar({
    @required ScrollController scrollController,
    @required String query,
    @required bool autofocus,
}) => LunaAppBar(
    title: 'Add Series',
    scrollControllers: [scrollController],
    bottom: _SearchBar(
        scrollController: scrollController,
        query: query ?? '',
        autofocus: autofocus,
    ),
);

class _SearchBar extends StatefulWidget implements PreferredSizeWidget {
    final ScrollController scrollController;
    final String query;
    final bool autofocus;

    _SearchBar({
        Key key,
        @required this.scrollController,
        @required this.query,
        @required this.autofocus,
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
        _controller.text = widget.query;
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
                            autofocus: widget.autofocus,
                            onChanged: (value) => context.read<SonarrAddSeriesState>().searchQuery = value,
                            onSubmitted: (value) {
                                if(value.isNotEmpty) context.read<SonarrAddSeriesState>().fetchLookup(context);
                            },
                            margin: LunaTextInputBar.appBarMargin,
                        ),
                    ),
                ],
            ),
            height: LunaTextInputBar.appBarHeight,
        ),
    );
}
