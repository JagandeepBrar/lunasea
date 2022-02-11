import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

// ignore: non_constant_identifier_names
Widget ReadarrAuthorAddAppBar({
  required ScrollController scrollController,
  required String? query,
  required bool autofocus,
}) =>
    LunaAppBar(
      title: 'readarr.AddAuthor'.tr(),
      scrollControllers: [scrollController],
      bottom: _SearchBar(
        scrollController: scrollController,
        query: query ?? '',
        autofocus: autofocus,
      ),
    );

class _SearchBar extends StatefulWidget implements PreferredSizeWidget {
  final String query;
  final bool autofocus;
  final ScrollController scrollController;

  const _SearchBar({
    Key? key,
    required this.query,
    required this.autofocus,
    required this.scrollController,
  }) : super(key: key);

  @override
  Size get preferredSize =>
      const Size.fromHeight(LunaTextInputBar.defaultAppBarHeight);

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
  Widget build(BuildContext context) => Consumer<ReadarrState>(
        builder: (context, state, _) => SizedBox(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: LunaTextInputBar(
                  controller: _controller,
                  scrollController: widget.scrollController,
                  autofocus: widget.autofocus,
                  onChanged: (value) =>
                      context.read<ReadarrAddSeriesState>().searchQuery = value,
                  onSubmitted: (value) {
                    if (value.isNotEmpty)
                      context.read<ReadarrAddSeriesState>().fetchLookup(context);
                  },
                  margin: LunaTextInputBar.appBarMargin,
                ),
              ),
            ],
          ),
          height: LunaTextInputBar.defaultAppBarHeight,
        ),
      );
}
