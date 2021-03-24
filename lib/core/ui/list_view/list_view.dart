import 'package:flutter/material.dart';

class LunaListView extends StatelessWidget {
    final List<Widget> children;
    final double itemExtent;
    final EdgeInsetsGeometry padding;
    final ScrollPhysics physics;
    final ScrollController controller;

    LunaListView({
        Key key,
        @required this.children,
        @required this.controller,
        this.itemExtent,
        this.padding,
        this.physics = const AlwaysScrollableScrollPhysics(),
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return NotificationListener<ScrollStartNotification>(
            onNotification: (notification) {
                if(notification.dragDetails != null) FocusManager.instance.primaryFocus?.unfocus();
                return null;
            },
            child: Scrollbar(
                controller: controller,
                child: ListView(
                    controller: controller,
                    children: children,
                    itemExtent: itemExtent,
                    padding: padding != null ? padding : EdgeInsets.only(
                        top: 8.0,
                        bottom: 8.0+(MediaQuery.of(context).padding.bottom),
                    ),
                    physics: physics,
                ),
            ),
        );
    }
}
