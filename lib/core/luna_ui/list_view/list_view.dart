import 'package:flutter/material.dart';

class LunaListView extends StatefulWidget {
    final List<Widget> children;
    final EdgeInsetsGeometry padding;
    final ScrollController scrollController;
    final ScrollPhysics physics;

    LunaListView({
        Key key,
        @required this.children,
        this.scrollController,
        this.padding,
        this.physics = const AlwaysScrollableScrollPhysics(),
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<LunaListView> {
    ScrollController _scrollController;

    @override
    void initState() {
        super.initState();
        _scrollController = widget.scrollController ?? ScrollController();
    }

    @override
    Widget build(BuildContext context) {
        return NotificationListener<ScrollStartNotification>(
            onNotification: (notification) {
                if(notification.dragDetails != null) FocusManager.instance.primaryFocus?.unfocus();
                return null;
            },
            child: Scrollbar(
                controller: _scrollController,
                child: ListView(
                    controller: _scrollController,
                    children: widget.children,
                    padding: widget.padding != null ? widget.padding : EdgeInsets.only(
                        top: 8.0,
                        bottom: 8.0+(MediaQuery.of(context).padding.bottom/5),
                    ),
                    physics: widget.physics,
                ),
            ),
        );
    }
}
