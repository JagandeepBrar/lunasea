import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrReleasesSearchBar extends StatefulWidget
    implements PreferredSizeWidget {
  final ScrollController scrollController;

  const SonarrReleasesSearchBar({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  Size get preferredSize =>
      const Size.fromHeight(LunaTextInputBar.defaultAppBarHeight);

  @override
  State<SonarrReleasesSearchBar> createState() => _State();
}

class _State extends State<SonarrReleasesSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Consumer<SonarrReleasesState>(
            builder: (context, state, _) => LunaTextInputBar(
              controller: _controller,
              scrollController: widget.scrollController,
              autofocus: false,
              onChanged: (value) =>
                  context.read<SonarrReleasesState>().searchQuery = value,
              margin: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 14.0),
            ),
          ),
        ),
        SonarrReleasesAppBarFilterButton(controller: widget.scrollController),
        SonarrReleasesAppBarSortButton(controller: widget.scrollController),
      ],
    );
  }
}
