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
  final LunaBottomActionBar actionBar;
  final LunaAppBar appBar;
  final double itemExtent;

  const LunaListViewModal({
    Key key,
    @required this.children,
    this.appBar,
    this.actionBar,
    this.itemExtent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: ModalScrollController.of(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (appBar != null) appBar,
          Flexible(
            child: ListView(
              controller: ModalScrollController.of(context),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: children,
              itemExtent: itemExtent,
              shrinkWrap: true,
              padding: _padding(context),
              physics: const ClampingScrollPhysics(),
            ),
          ),
          if (actionBar != null) actionBar,
        ],
      ),
    );
  }

  EdgeInsets _padding(BuildContext context) {
    EdgeInsets _mediaQuery = MediaQuery.of(context).padding;
    return EdgeInsets.fromLTRB(
      _mediaQuery.left,
      _mediaQuery.top + LunaUI.MARGIN_CARD.top,
      _mediaQuery.right,
      actionBar != null ? 0 : _mediaQuery.bottom + LunaUI.MARGIN_CARD.bottom,
    );
  }
}
