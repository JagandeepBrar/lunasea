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
    final String noItemsFoundMessage;

    LunaPagedListView({
        Key key,
        @required this.refreshKey,
        @required this.pagingController,
        this.scrollController,
        @required this.listener,
        @required this.itemBuilder,
        @required this.noItemsFoundMessage,
        this.padding,
    }) : super(key: key) {
        assert(refreshKey != null);
        assert(pagingController != null);
        assert(listener != null);
        assert(itemBuilder != null);
        assert(noItemsFoundMessage != null);
    }

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
    Widget build(BuildContext context) {
        return NotificationListener<ScrollStartNotification>(
            onNotification: (notification) {
                if(notification.dragDetails != null) FocusManager.instance.primaryFocus?.unfocus();
                return null;
            },
            child: LunaRefreshIndicator(
                key: widget.refreshKey,
                context: context,
                onRefresh: () => Future.sync(() => widget.pagingController.refresh()),
                child: Scrollbar(
                    controller: _scrollController,
                    child: PagedListView<int, T>(
                        pagingController: widget.pagingController,
                        scrollController: _scrollController,
                        builderDelegate: PagedChildBuilderDelegate<T>(
                            itemBuilder: widget.itemBuilder,
                            firstPageErrorIndicatorBuilder: (context) => LunaMessage.error(onTap: () => Future.sync(() => widget.pagingController.refresh())),
                            firstPageProgressIndicatorBuilder: (context) => LunaLoader(),
                            newPageProgressIndicatorBuilder: (context) => Container(
                                alignment: Alignment.center,
                                height: 40.0,
                                child: LunaLoader(size: 16.0),
                            ),
                            newPageErrorIndicatorBuilder: (context) => LunaIconButton(icon: Icons.error, color: LunaColours.red),
                            noItemsFoundIndicatorBuilder: (context) => LunaMessage(
                                text: widget.noItemsFoundMessage,
                                buttonText: 'Try Again',
                                onTap: () => Future.sync(() => widget.pagingController.refresh()),
                                useSafeArea: true,
                            ),
                            noMoreItemsIndicatorBuilder: (context) => LunaIconButton(icon: Icons.check, color: LunaColours.accent),
                        ),
                        padding: widget.padding != null ? widget.padding : EdgeInsets.only(
                            top: 8.0,
                            bottom: 8.0+(MediaQuery.of(context).padding.bottom/5),
                        ),
                        physics: AlwaysScrollableScrollPhysics(),
                    ),
                ),
            ),
        );
    }
}
