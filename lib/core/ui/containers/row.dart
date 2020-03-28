import 'package:flutter/material.dart';

class LSContainerRow extends StatelessWidget {
    final List<Widget> children;
    final EdgeInsets padding;
    final Color backgroundColor;

    LSContainerRow({
        @required this.children,
        this.backgroundColor,
        this.padding = const EdgeInsets.symmetric(horizontal: 6.0),
    });

    @override
    Widget build(BuildContext context) => Padding(
        child: Container(
            child: Row(
                children: children,
            ),
            decoration: BoxDecoration(
                color: backgroundColor,
            ),
        ),
        padding: padding,
    );
}