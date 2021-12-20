import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaReorderableListViewDragger extends StatelessWidget {
  final int index;

  const LunaReorderableListViewDragger({
    Key key,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ReorderableDragStartListener(
          index: index,
          child: const Icon(
            Icons.menu_rounded,
            size: LunaUI.ICON_SIZE_DEFAULT,
          ),
        ),
      ],
    );
  }
}
