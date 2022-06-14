import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

/// [ListView] with a [Scrollbar] that is intended to be used with a modal bottom sheet.
///
/// The [ScrollController] is pulled from the context from the sheet, and cannot be defined.
///
/// By default, the list is shrink-wrapped.
class LunaListViewModal extends StatelessWidget {
  final List<Widget> children;
  final LunaBottomActionBar? actionBar;
  final LunaAppBar? appBar;
  final double? itemExtent;

  const LunaListViewModal({
    Key? key,
    required this.children,
    this.appBar,
    this.actionBar,
    this.itemExtent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (appBar != null) appBar!,
        Flexible(
          child: Scrollbar(
            controller: ModalScrollController.of(context),
            interactive: true,
            child: ListView(
              controller: ModalScrollController.of(context),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: children,
              itemExtent: itemExtent,
              shrinkWrap: true,
              padding: _padding(context),
              physics: const AlwaysScrollableScrollPhysics(),
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
