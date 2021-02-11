import 'package:flutter/material.dart';

class LunaListViewBuilder extends StatefulWidget {
    final int itemCount;
    final Widget Function(BuildContext, int) itemBuilder;
    final EdgeInsetsGeometry padding;
    final ScrollController scrollController;
    final ScrollPhysics physics;

    LunaListViewBuilder({
        Key key,
        @required this.itemCount,
        @required this.itemBuilder,
        this.scrollController,
        this.padding,
        this.physics = const AlwaysScrollableScrollPhysics(),
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<LunaListViewBuilder> {
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
                child: ListView.builder(
                    controller: _scrollController,
                    padding: widget.padding != null ? widget.padding : EdgeInsets.only(
                        top: 8.0,
                        bottom: 8.0+(MediaQuery.of(context).padding.bottom/5),
                    ),
                    physics: widget.physics,
                    itemCount: widget.itemCount,
                    itemBuilder: widget.itemBuilder,
                ),
            ),
        );
    }
}
