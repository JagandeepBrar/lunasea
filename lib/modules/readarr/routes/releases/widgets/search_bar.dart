import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrReleasesSearchBar extends StatefulWidget
    implements PreferredSizeWidget {
  final ScrollController scrollController;

  const ReadarrReleasesSearchBar({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  Size get preferredSize =>
      const Size.fromHeight(LunaTextInputBar.defaultAppBarHeight);

  @override
  State<ReadarrReleasesSearchBar> createState() => _State();
}

class _State extends State<ReadarrReleasesSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Consumer<ReadarrReleasesState>(
            builder: (context, state, _) => LunaTextInputBar(
              controller: _controller,
              scrollController: widget.scrollController,
              autofocus: false,
              onChanged: (value) =>
                  context.read<ReadarrReleasesState>().searchQuery = value,
              margin: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 14.0),
            ),
          ),
        ),
        ReadarrReleasesAppBarFilterButton(controller: widget.scrollController),
        ReadarrReleasesAppBarSortButton(controller: widget.scrollController),
      ],
    );
  }
}
