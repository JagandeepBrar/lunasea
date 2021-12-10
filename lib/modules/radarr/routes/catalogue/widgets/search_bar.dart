import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrCatalogueSearchBar extends StatefulWidget
    implements PreferredSizeWidget {
  final ScrollController scrollController;

  const RadarrCatalogueSearchBar({
    Key key,
    @required this.scrollController,
  }) : super(key: key);

  @override
  Size get preferredSize =>
      const Size.fromHeight(LunaTextInputBar.defaultAppBarHeight);

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
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Consumer<RadarrState>(
            builder: (context, state, _) => LunaTextInputBar(
              controller: _controller,
              scrollController: widget.scrollController,
              autofocus: false,
              onChanged: (value) =>
                  context.read<RadarrState>().moviesSearchQuery = value,
              margin: EdgeInsets.zero,
            ),
          ),
        ),
        RadarrCatalogueSearchBarFilterButton(
            controller: widget.scrollController),
        RadarrCatalogueSearchBarSortButton(controller: widget.scrollController),
      ],
    );
  }
}
