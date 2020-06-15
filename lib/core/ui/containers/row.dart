import 'package:flutter/material.dart';

class LSContainerRow extends StatelessWidget {
    final List<Widget> children;
    final EdgeInsets padding;
    final Color backgroundColor;
    final MainAxisAlignment mainAxisAlignment;
    final CrossAxisAlignment crossAxisAlignment;

    LSContainerRow({
        @required this.children,
        this.backgroundColor,
        this.padding = const EdgeInsets.symmetric(horizontal: 6.0),
        this.mainAxisAlignment = MainAxisAlignment.start,
        this.crossAxisAlignment = CrossAxisAlignment.start,
    });

    @override
    Widget build(BuildContext context) => Padding(
        child: Container(
            child: Row(
                mainAxisAlignment: mainAxisAlignment,
                crossAxisAlignment: crossAxisAlignment,
                children: children,
            ),
            decoration: BoxDecoration(
                color: backgroundColor,
            ),
        ),
        padding: padding,
    );
}