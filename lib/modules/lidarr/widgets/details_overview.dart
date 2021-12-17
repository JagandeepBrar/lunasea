import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrDetailsOverview extends StatefulWidget {
  final LidarrCatalogueData data;

  const LidarrDetailsOverview({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  State<LidarrDetailsOverview> createState() => _State();
}

class _State extends State<LidarrDetailsOverview>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LunaListView(
      controller: LidarrArtistNavigationBar.scrollControllers[0],
      children: <Widget>[
        LidarrDescriptionBlock(
          title: widget?.data?.title ?? 'Unknown',
          description: widget?.data?.overview == ''
              ? 'No summary is available.'
              : widget?.data?.overview,
          uri: widget?.data?.posterURI() ?? '',
          squareImage: true,
          headers: Database.currentProfileObject.getLidarr()['headers'],
        ),
        LunaButtonContainer(
          buttonsPerRow: 4,
          children: [
            if (widget.data.bandsintownURI != null &&
                widget.data.bandsintownURI.isNotEmpty)
              LunaCard(
                context: context,
                child: InkWell(
                  child: Padding(
                    child: Image.asset(LunaAssets.serviceBandsintown),
                    padding: const EdgeInsets.all(12.0),
                  ),
                  borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
                  onTap: () async =>
                      await widget.data?.bandsintownURI?.lunaOpenGenericLink(),
                ),
                height: 50.0,
                margin:
                    const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
              ),
            if (widget.data.discogsURI != null &&
                widget.data.discogsURI.isNotEmpty)
              LunaCard(
                context: context,
                child: InkWell(
                  child: Padding(
                    child: Image.asset(LunaAssets.serviceDiscogs),
                    padding: const EdgeInsets.all(12.0),
                  ),
                  borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
                  onTap: () async =>
                      await widget.data?.discogsURI?.lunaOpenGenericLink(),
                ),
                height: 50.0,
                margin:
                    const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
              ),
            if (widget.data.lastfmURI != null &&
                widget.data.lastfmURI.isNotEmpty)
              LunaCard(
                context: context,
                child: InkWell(
                  child: Padding(
                    child: Image.asset(LunaAssets.serviceLastfm),
                    padding: const EdgeInsets.all(12.0),
                  ),
                  borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
                  onTap: () async =>
                      await widget.data?.lastfmURI?.lunaOpenGenericLink(),
                ),
                height: 50.0,
                margin:
                    const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
              ),
          ],
        ),
        LunaTableCard(
          content: [
            LunaTableContent(
                title: 'Path', body: widget?.data?.path ?? LunaUI.TEXT_EMDASH),
            LunaTableContent(
                title: 'Quality',
                body: widget?.data?.quality ?? LunaUI.TEXT_EMDASH),
            LunaTableContent(
                title: 'Metadata',
                body: widget?.data?.metadata ?? LunaUI.TEXT_EMDASH),
            LunaTableContent(
                title: 'Albums',
                body: widget?.data?.albums ?? LunaUI.TEXT_EMDASH),
            LunaTableContent(
                title: 'Tracks',
                body: widget?.data?.tracks ?? LunaUI.TEXT_EMDASH),
            LunaTableContent(
                title: 'Genres',
                body: widget?.data?.genre ?? LunaUI.TEXT_EMDASH),
          ],
        ),
      ],
    );
  }
}
