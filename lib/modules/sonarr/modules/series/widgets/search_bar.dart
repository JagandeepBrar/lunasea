import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesSearchBar extends StatefulWidget implements PreferredSizeWidget {
    final ScrollController scrollController;

    SonarrSeriesSearchBar({
        Key key,
        @required this.scrollController,
    }) : super(key: key);

    @override
    Size get preferredSize => Size.fromHeight(62.0);

    @override
    State<SonarrSeriesSearchBar> createState() => _State();
}

class _State extends State<SonarrSeriesSearchBar> {
    final TextEditingController _controller = TextEditingController();

    @override
    void initState() {
        super.initState();
        _controller.text = context.read<SonarrState>().seriesSearchQuery;
    }

    @override
    Widget build(BuildContext context) => Padding(
        child: Row(
            children: [
                Expanded(
                    child: Consumer<SonarrState>(
                        builder: (context, state, _) => LSTextInputBar(
                            controller: _controller,
                            autofocus: false,
                            onChanged: (text, updateController) => _onChange(text, updateController),
                            margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 14.0),
                        ),
                    ),
                ),
                SonarrSeriesSearchBarFilterButton(controller: widget.scrollController),
                SonarrSeriesSearchBarSortButton(controller: widget.scrollController),
            ],
        ),
        padding: EdgeInsets.only(top: 1.0, bottom: 1.0),
    );

    void _onChange(String text, bool updateController) {
        context.read<SonarrState>().seriesSearchQuery = text;
        if(updateController) _controller.text = text;
    }
}
