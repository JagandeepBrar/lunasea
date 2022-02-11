import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrAuthorDetailsBooksPage extends StatefulWidget {
  final ReadarrAuthor? author;
  final List<ReadarrBook>? books;

  const ReadarrAuthorDetailsBooksPage({
    Key? key,
    required this.author,
    required this.books,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ReadarrAuthorDetailsBooksPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      module: LunaModule.READARR,
      hideDrawer: true,
      body: _body(),
    );
  }

  Widget _body() {
    return LunaRefreshIndicator(
      key: _refreshKey,
      context: context,
      onRefresh: () async => context.read<ReadarrState>().fetchAuthor(
            widget.author!.id!,
          ),
      child: _list(),
    );
  }

  Widget _list() {
    if (widget.books?.isEmpty ?? true) {
      return LunaMessage(
        text: 'readarr.NoBooksFound'.tr(),
        buttonText: 'lunasea.Refresh'.tr(),
        onTap: _refreshKey.currentState!.show,
      );
    }
    List<ReadarrBook> _books = widget.books!;
    _books.sort((a, b) => a.releaseDate!.compareTo(b.releaseDate!));
    return LunaListView(
      controller: ReadarrAuthorDetailsNavigationBar.scrollControllers[1],
      children: [
        ...List.generate(
          _books.length,
          (index) => ReadarrAuthorDetailsBookTile(
            authorId: widget.author!.id,
            book: _books[_books.length - 1 - index],
          ),
        ),
      ],
    );
  }
}
