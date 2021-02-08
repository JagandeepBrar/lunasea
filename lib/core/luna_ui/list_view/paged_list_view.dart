import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lunasea/core.dart';

class LunaPagedListView<T> extends StatefulWidget {
    final GlobalKey<RefreshIndicatorState> refreshKey;
    final PagingController<int, T> pagingController;
    final ScrollController scrollController;
    final void Function(int) listener;
    final Widget Function(BuildContext, T, int) itemBuilder;
    final EdgeInsetsGeometry padding;

    LunaPagedListView({
        Key key,
        @required this.refreshKey,
        @required this.pagingController,
        this.scrollController,
        @required this.listener,
        @required this.itemBuilder,
        this.padding,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State<T>();
}

class _State<T> extends State<LunaPagedListView<T>> {
    ScrollController _scrollController;

    @override
    void initState() {
        super.initState();
        _scrollController = widget.scrollController ?? ScrollController();
        widget.pagingController.addPageRequestListener((pageKey) => widget.listener(pageKey));
    }

    @override
    Widget build(BuildContext context) => LSRefreshIndicator(
        refreshKey: widget.refreshKey,
        onRefresh: () => Future.sync(() => widget.pagingController.refresh()),
        child: Scrollbar(
            controller: _scrollController,
            child: PagedListView<int, T>(
                pagingController: widget.pagingController,
                scrollController: _scrollController,
                builderDelegate: PagedChildBuilderDelegate<T>(
                    itemBuilder: widget.itemBuilder,
                    firstPageErrorIndicatorBuilder: (context) => LSErrorMessage(onTapHandler: () => Future.sync(() => widget.pagingController.refresh())),
                    firstPageProgressIndicatorBuilder: (context) => LSLoader(),
                    newPageProgressIndicatorBuilder: (context) => Container(
                        alignment: Alignment.center,
                        height: 32.0,
                        child: LSLoader(size: 16.0),
                    ),
                    // TODO: No more items, error on new page, etc.
                ),
                padding: widget.padding != null ? widget.padding : EdgeInsets.only(
                    top: 8.0,
                    bottom: 8.0+(MediaQuery.of(context).padding.bottom/5),
                ),
                physics: AlwaysScrollableScrollPhysics(),
            ),
        ),
    );
}
