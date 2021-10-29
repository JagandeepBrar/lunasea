import 'package:flutter/material.dart';

class LunaButtonContainer extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets padding;

  LunaButtonContainer({
    Key key,
    @required this.children,
    this.padding = const EdgeInsets.symmetric(horizontal: 6.0),
  }) : super(key: key) {
    assert(children != null);
    assert(children?.isNotEmpty ?? false);
    assert(padding != null);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Row(
        children: children
            .map<Expanded>((button) => Expanded(child: button))
            .toList(),
      ),
      padding: padding,
    );
  }
}
