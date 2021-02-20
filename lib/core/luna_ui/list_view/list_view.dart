import 'package:flutter/material.dart';

class LunaListView extends StatelessWidget {
    final List<Widget> children;
    final EdgeInsetsGeometry padding;
    final ScrollPhysics physics;
    final ScrollController controller;

    LunaListView({
        Key key,
        @required this.children,
        @required this.controller,
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
                    padding: padding != null ? padding : EdgeInsets.only(
                        top: 8.0,
                        bottom: 8.0+(MediaQuery.of(context).padding.bottom/5),
                    ),
                    physics: physics,
                ),
            ),
        );
    }
}
