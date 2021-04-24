import 'package:flutter/material.dart';

class LunaReorderableListDragger extends StatelessWidget {
  final int index;

  LunaReorderableListDragger({
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
          child: Icon(Icons.menu_rounded),
        ),
      ],
    );
  }
}
