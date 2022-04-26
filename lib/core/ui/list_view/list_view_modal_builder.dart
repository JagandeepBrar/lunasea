import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

/// [ListView] builder with a [Scrollbar] that is intended to be used with a modal bottom sheet.
///
/// The [ScrollController] is pulled from the context from the sheet, and cannot be defined.
///
/// By default, the list is shrink-wrapped.
class LunaListViewModalBuilder extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final LunaBottomActionBar? actionBar;
  final LunaAppBar? appBar;
  final double? appBarHeight;
  final double? itemExtent;

  const LunaListViewModalBuilder({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    this.appBar,
    this.appBarHeight,
    this.actionBar,
    this.itemExtent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (appBar != null)
          SizedBox(
            child: appBar,
            height: appBarHeight,
          ),
        Flexible(
          child: Scrollbar(
            controller: ModalScrollController.of(context),
            interactive: true,
            child: ListView.builder(
              controller: ModalScrollController.of(context),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: _padding(context),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: itemCount,
              itemBuilder: itemBuilder,
              itemExtent: itemExtent,
              shrinkWrap: true,
            ),
          ),
        ),
        if (actionBar != null) actionBar!,
      ],
    );
  }

  EdgeInsets _padding(BuildContext context) {
    EdgeInsets _padding = MediaQuery.of(context).padding;
    EdgeInsets _viewInsets = MediaQuery.of(context).viewInsets;

    return EdgeInsets.fromLTRB(
      _padding.left + _viewInsets.left,
      appBar != null
          ? LunaUI.MARGIN_H_DEFAULT_V_HALF.top
          : _padding.top + _viewInsets.top + LunaUI.MARGIN_H_DEFAULT_V_HALF.top,
      _padding.right + _viewInsets.right,
      actionBar != null
          ? 0
          : _padding.bottom +
              _viewInsets.bottom +
              LunaUI.MARGIN_H_DEFAULT_V_HALF.bottom,
    );
  }
}
