import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class LSExpandable extends StatefulWidget {
    final ExpandableController controller;
    final Widget collapsed;
    final Widget expanded;

    LSExpandable({
        @required this.controller,
        @required this.collapsed,
        @required this.expanded,
        Key key,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<LSExpandable> {
    @override
    Widget build(BuildContext context) => ExpandableNotifier(
        controller: widget.controller,
        child: Expandable(
            collapsed: widget.collapsed,
            expanded: widget.expanded,
        ),
    );
}