import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarSeriesSearchBar extends StatefulWidget {
  final ScrollController scrollController;

  const MylarSeriesSearchBar({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<MylarSeriesSearchBar> createState() => _State();
}

class _State extends State<MylarSeriesSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _controller.text = context.read<MylarState>().seriesSearchQuery;
    _focusNode.addListener(_handleFocus);
  }

  void _handleFocus() {
    if (_focusNode.hasPrimaryFocus != _hasFocus)
      setState(() => _hasFocus = _focusNode.hasPrimaryFocus);
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _sc = widget.scrollController;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Consumer<MylarState>(
            builder: (context, state, _) => LunaTextInputBar(
              controller: _controller,
              scrollController: _sc,
              focusNode: _focusNode,
              autofocus: false,
              onChanged: (value) =>
                  context.read<MylarState>().seriesSearchQuery = value,
              margin: EdgeInsets.zero,
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(
            milliseconds: LunaUI.ANIMATION_SPEED_SCROLLING,
          ),
          curve: Curves.easeInOutQuart,
          width: _hasFocus
              ? 0.0
              : (LunaTextInputBar.defaultHeight * 3 +
                  LunaUI.DEFAULT_MARGIN_SIZE * 3),
          child: Row(
            children: [
              Flexible(
                child: MylarSeriesSearchBarFilterButton(controller: _sc),
              ),
              Flexible(
                child: MylarSeriesSearchBarSortButton(controller: _sc),
              ),
              Flexible(
                child: MylarSeriesSearchBarViewButton(controller: _sc),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
