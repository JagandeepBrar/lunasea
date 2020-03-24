import 'package:flutter/material.dart';

class LSContainerRow extends StatelessWidget {
    final List<Widget> children;
    final EdgeInsets padding;

    LSContainerRow({
        @required this.children,
        this.padding = const EdgeInsets.symmetric(horizontal: 6.0),
    });

    @override
    Widget build(BuildContext context) => Padding(
        child: Row(
            children: children,
        ),
        padding: padding,
    );
}