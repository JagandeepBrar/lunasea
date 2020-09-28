import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LSTableBlock extends StatelessWidget {
    final String title;
    final List<Widget> children;

    LSTableBlock({
        Key key,
        this.title,
        @required this.children,
    }) : super(key: key);

    List<Widget> _block({
        String title,
        @required List<Widget> children,
    }) => [
        if(title != null) LSHeader(text: title),
        LSCard(
            child: Padding(
                child: Column(
                    children: children,
                ),
                padding: EdgeInsets.symmetric(vertical: 8.0),
            ),
        ),
    ];

    @override
    Widget build(BuildContext context) => Column(
        children: _block(title: title, children: children),
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
    );
}
