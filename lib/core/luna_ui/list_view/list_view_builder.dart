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
        this.padding = const EdgeInsets.symmetric(vertical: 8.0),
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
    Widget build(BuildContext context) => Scrollbar(
        controller: _scrollController,
        child: ListView.builder(
            controller: _scrollController,
            padding: widget.padding,
            physics: widget.physics,
            itemCount: widget.itemCount,
            itemBuilder: widget.itemBuilder,
        ),
    );
}
