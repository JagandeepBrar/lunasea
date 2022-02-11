import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrBookDetailsOverviewPage extends StatefulWidget {
  final ReadarrBook? book;

  const ReadarrBookDetailsOverviewPage({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ReadarrBookDetailsOverviewPage>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LunaScaffold(
      module: LunaModule.RADARR,
      hideDrawer: true,
      scaffoldKey: _scaffoldKey,
      body: Selector<ReadarrState, Future<Map<int, ReadarrBook>>?>(
        selector: (_, state) => state.books,
        builder: (context, movies, _) => LunaListView(
          controller: ReadarrBookDetailsNavigationBar.scrollControllers[0],
          children: [
            ReadarrBookDetailsOverviewDescriptionTile(book: widget.book),
            ReadarrBookDetailsOverviewLinksSection(movie: widget.book),
            ReadarrBookDetailsOverviewInformationBlock(
              book: widget.book,
            ),
          ],
        ),
      ),
    );
  }
}
