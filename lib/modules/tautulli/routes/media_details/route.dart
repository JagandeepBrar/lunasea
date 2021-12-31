import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliMediaDetailsRouter extends TautulliPageRouter {
  TautulliMediaDetailsRouter() : super('/tautulli/media/:mediatype/:ratingkey');

  @override
  _Widget widget([
    int ratingKey = -1,
    TautulliMediaType mediaType = TautulliMediaType.NULL,
  ]) =>
      _Widget(
        ratingKey: ratingKey,
        mediaType: mediaType,
      );

  @override
  Future<void> navigateTo(
    BuildContext context, [
    int ratingKey = -1,
    TautulliMediaType mediaType = TautulliMediaType.NULL,
  ]) async {
    LunaRouter.router.navigateTo(
      context,
      route(ratingKey, mediaType),
    );
  }

  @override
  String route([
    int ratingKey = -1,
    TautulliMediaType mediaType = TautulliMediaType.NULL,
  ]) =>
      fullRoute
          .replaceFirst(':mediatype', mediaType.value ?? 'mediatype')
          .replaceFirst(':ratingkey', ratingKey.toString());

  @override
  void defineRoute(FluroRouter router) => super.withParameterRouteDefinition(
        router,
        (context, params) {
          TautulliMediaType? mediaType =
              (params['mediatype']?.isNotEmpty ?? false)
                  ? TautulliMediaType.NULL.from(params['mediatype']![0])
                  : null;
          int ratingKey = (params['ratingkey']?.isNotEmpty ?? false)
              ? int.tryParse(params['ratingkey']![0]) ?? -1
              : -1;
          return _Widget(
            ratingKey: ratingKey,
            mediaType: mediaType,
          );
        },
      );
}

class _Widget extends StatefulWidget {
  final int ratingKey;
  final TautulliMediaType? mediaType;

  const _Widget({
    Key? key,
    required this.ratingKey,
    required this.mediaType,
  }) : super(key: key);

  @override
  State<_Widget> createState() => _State();
}

class _State extends State<_Widget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  LunaPageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = LunaPageController(
        initialPage: TautulliDatabaseValue.NAVIGATION_INDEX_MEDIA_DETAILS.data);
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
    );
  }

  Widget? _bottomNavigationBar() {
    if (widget.mediaType != null &&
        widget.mediaType != TautulliMediaType.NULL &&
        widget.mediaType != TautulliMediaType.COLLECTION)
      return TautulliMediaDetailsNavigationBar(pageController: _pageController);
    return null;
  }

  Widget _body() {
    if (widget.mediaType == null ||
        widget.mediaType == TautulliMediaType.NULL ||
        widget.ratingKey == null) return LunaMessage(text: 'No Content Found');
    if (widget.mediaType == TautulliMediaType.COLLECTION)
      return TautulliMediaDetailsMetadata(
        ratingKey: widget.ratingKey,
        type: widget.mediaType,
      );
    return PageView(
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
