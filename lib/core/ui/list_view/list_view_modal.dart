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
  final double itemExtent;
  final bool shrinkWrap;

  LunaListViewModal({
    Key key,
    @required this.children,
    this.itemExtent,
    this.shrinkWrap = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: ModalScrollController.of(context),
      child: ListView(
        controller: ModalScrollController.of(context),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: children,
        itemExtent: itemExtent,
        shrinkWrap: shrinkWrap,
        padding: MediaQuery.of(context).padding.add(EdgeInsets.symmetric(
              vertical: LunaUI.MARGIN_CARD.bottom,
            )),
        physics: AlwaysScrollableScrollPhysics(),
      ),
    );
  }
}
