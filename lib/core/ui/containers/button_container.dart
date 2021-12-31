import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaButtonContainer extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets padding;
  final int buttonsPerRow;

  const LunaButtonContainer({
    Key? key,
    required this.children,
    this.buttonsPerRow = 2,
    this.padding = const EdgeInsets.symmetric(horizontal: 6.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children
            .chunked(buttonsPerRow)
            .map((child) => Row(
                  children: child
                      .map<Expanded>((button) => Expanded(child: button))
                      .toList(),
                ))
            .toList(),
      ),
      padding: padding,
    );
  }
}
