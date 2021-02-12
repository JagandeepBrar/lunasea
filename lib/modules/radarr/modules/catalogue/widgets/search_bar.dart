import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrCatalogueSearchBar extends StatefulWidget implements PreferredSizeWidget {
    final ScrollController scrollController;

    RadarrCatalogueSearchBar({
        Key key,
        @required this.scrollController,
    }) : super(key: key);

    @override
    Size get preferredSize => Size.fromHeight(62.0);

    @override
    State<RadarrCatalogueSearchBar> createState() => _State();
}

class _State extends State<RadarrCatalogueSearchBar> {
    final TextEditingController _controller = TextEditingController();

    @override
    void initState() {
        super.initState();
        _controller.text = context.read<RadarrState>().moviesSearchQuery;
    }

    @override
    Widget build(BuildContext context) {
        return Row(
            children: [
                Expanded(
                    child: Consumer<RadarrState>(
                        builder: (context, state, _) => LunaTextInputBar(
                            controller: _controller,
                            autofocus: false,
                            onChanged: (value) => context.read<RadarrState>().moviesSearchQuery = value,
                            margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 14.0),
                        ),
                    ),
                ),
                RadarrCatalogueSearchBarFilterButton(controller: widget.scrollController),
                RadarrCatalogueSearchBarSortButton(controller: widget.scrollController),
            ],
        );
    }
}
