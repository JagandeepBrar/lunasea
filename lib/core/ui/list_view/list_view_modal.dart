import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class LunaListViewModal extends StatelessWidget {
    final List<Widget> children;

    LunaListViewModal({
        Key key,
        @required this.children,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scrollbar(
            controller: ModalScrollController.of(context),
            child: ListView(
                controller: ModalScrollController.of(context),
                children: children,
                padding: EdgeInsets.only(
                    top: 8.0,
                    bottom: 8.0+(MediaQuery.of(context).padding.bottom),
                ),
                physics: AlwaysScrollableScrollPhysics(),
            ),
        );
    }
}
