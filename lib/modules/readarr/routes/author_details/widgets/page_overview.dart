import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrAuthorDetailsOverviewPage extends StatefulWidget {
  final ReadarrAuthor author;
  final ReadarrQualityProfile? qualityProfile;
  final ReadarrMetadataProfile? metadataProfile;
  final List<ReadarrTag> tags;

  const ReadarrAuthorDetailsOverviewPage({
    Key? key,
    required this.author,
    required this.qualityProfile,
    required this.metadataProfile,
    required this.tags,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ReadarrAuthorDetailsOverviewPage>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      module: LunaModule.READARR,
      hideDrawer: true,
      body: Selector<ReadarrState, Future<Map<int?, ReadarrAuthor>>?>(
        selector: (_, state) => state.authors,
        builder: (context, movies, _) => LunaListView(
          controller: ReadarrAuthorDetailsNavigationBar.scrollControllers[0],
          children: [
            ReadarrAuthorDetailsOverviewDescriptionTile(series: widget.author),
            ReadarrAuthorDetailsOverviewLinksSection(series: widget.author),
            ReadarrAuthorDetailsOverviewInformationBlock(
              series: widget.author,
              qualityProfile: widget.qualityProfile,
              metadataProfile: widget.metadataProfile,
              tags: widget.tags,
            )
          ],
        ),
      ),
    );
  }
}
