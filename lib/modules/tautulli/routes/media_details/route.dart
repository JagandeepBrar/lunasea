import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class MediaDetailsRoute extends StatefulWidget {
  final int ratingKey;
  final TautulliMediaType mediaType;

  const MediaDetailsRoute({
    Key? key,
    required this.ratingKey,
    required this.mediaType,
  }) : super(key: key);

  @override
  State<MediaDetailsRoute> createState() => _State();
}

class _State extends State<MediaDetailsRoute> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  LunaPageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = LunaPageController(
        initialPage: TautulliDatabase.NAVIGATION_INDEX_MEDIA_DETAILS.read());
  }

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
      bottomNavigationBar: _bottomNavigationBar(),
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'Media Details',
      scrollControllers: TautulliMediaDetailsNavigationBar.scrollControllers,
      pageController: _pageController,
      actions: [
        TautulliMediaDetailsOpenPlexButton(
          ratingKey: widget.ratingKey,
          mediaType: widget.mediaType,
        ),
      ],
    );
  }

  Widget? _bottomNavigationBar() {
    if (widget.mediaType != TautulliMediaType.NULL &&
        widget.mediaType != TautulliMediaType.COLLECTION)
      return TautulliMediaDetailsNavigationBar(pageController: _pageController);
    return null;
  }

  Widget _body() {
    if (widget.mediaType == TautulliMediaType.NULL)
      return const LunaMessage(text: 'No Content Found');
    if (widget.mediaType == TautulliMediaType.COLLECTION)
      return TautulliMediaDetailsMetadata(
        ratingKey: widget.ratingKey,
        type: widget.mediaType,
      );
    return LunaPageView(
      controller: _pageController,
      children: [
        TautulliMediaDetailsMetadata(
          ratingKey: widget.ratingKey,
          type: widget.mediaType,
        ),
        TautulliMediaDetailsHistory(
          ratingKey: widget.ratingKey,
          type: widget.mediaType,
        ),
      ],
    );
  }
}
