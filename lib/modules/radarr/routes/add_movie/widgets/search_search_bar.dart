import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAddMovieSearchSearchBar extends StatefulWidget
    implements PreferredSizeWidget {
  final String query;
  final bool autofocus;
  final ScrollController scrollController;

  const RadarrAddMovieSearchSearchBar({
    Key? key,
    required this.query,
    required this.autofocus,
    required this.scrollController,
  }) : super(key: key);

  @override
  Size get preferredSize =>
      const Size.fromHeight(LunaTextInputBar.defaultAppBarHeight);

  @override
  State<RadarrAddMovieSearchSearchBar> createState() => _State();
}

class _State extends State<RadarrAddMovieSearchSearchBar> {
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Expanded(
            child: Consumer<RadarrAddMovieState>(
              builder: (context, state, _) => LunaTextInputBar(
                controller: _controller,
                scrollController: widget.scrollController,
                autofocus: widget.autofocus,
                onChanged: (value) =>
                    context.read<RadarrAddMovieState>().searchQuery = value,
                onSubmitted: (value) {
                  if (value.isNotEmpty)
                    context.read<RadarrAddMovieState>().fetchLookup(context);
                },
                margin: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
      height: LunaTextInputBar.defaultAppBarHeight,
    );
  }
}
