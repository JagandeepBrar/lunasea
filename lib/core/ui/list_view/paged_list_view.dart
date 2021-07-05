import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaPagedListView<T> extends StatefulWidget {
  final GlobalKey<RefreshIndicatorState> refreshKey;
  final PagingController<int, T> pagingController;
  final ScrollController scrollController;
  final void Function(int) listener;
  final Widget Function(BuildContext, T, int) itemBuilder;
  final double itemExtent;
  final EdgeInsetsGeometry padding;
  final String noItemsFoundMessage;

  LunaPagedListView({
    Key key,
    @required this.refreshKey,
    @required this.pagingController,
    @required this.listener,
    @required this.itemBuilder,
    @required this.noItemsFoundMessage,
    @required this.scrollController,
    this.itemExtent,
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
  @override
  void initState() {
    super.initState();
    widget.pagingController
        .addPageRequestListener((pageKey) => widget.listener(pageKey));
  }

  @override
  Widget build(BuildContext context) {
    return LunaRefreshIndicator(
      key: widget.refreshKey,
      context: context,
      onRefresh: () => Future.sync(() => widget.pagingController.refresh()),
      child: Scrollbar(
        controller: widget.scrollController,
        child: PagedListView<int, T>(
          pagingController: widget.pagingController,
          scrollController: widget.scrollController,
          itemExtent: widget.itemExtent,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          builderDelegate: PagedChildBuilderDelegate<T>(
            itemBuilder: widget.itemBuilder,
            firstPageErrorIndicatorBuilder: (context) => LunaMessage.error(
                onTap: () =>
                    Future.sync(() => widget.pagingController.refresh())),
            firstPageProgressIndicatorBuilder: (context) => LunaLoader(),
            newPageProgressIndicatorBuilder: (context) => Padding(
              child: Container(
                alignment: Alignment.center,
                height: 48.0,
                child: LunaLoader(size: 16.0, useSafeArea: false),
              ),
              padding: EdgeInsets.only(bottom: 0.0),
            ),
            newPageErrorIndicatorBuilder: (context) => LunaIconButton(
              icon: Icons.error,
              color: LunaColours.red,
            ),
            noMoreItemsIndicatorBuilder: (context) => LunaIconButton(
              icon: Icons.check,
              color: LunaColours.accent,
            ),
            noItemsFoundIndicatorBuilder: (context) => LunaMessage(
              text: widget.noItemsFoundMessage,
              buttonText: 'lunasea.Refresh'.tr(),
              onTap: () => Future.sync(() => widget.pagingController.refresh()),
            ),
          ),
          padding: widget.padding ??
              MediaQuery.of(context)
                  .padding
                  .copyWith(bottom: LunaUI.MARGIN_CARD.bottom)
                  .add(EdgeInsets.only(top: LunaUI.MARGIN_CARD.top)),
          physics: AlwaysScrollableScrollPhysics(),
        ),
      ),
    );
  }
}
