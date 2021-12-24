import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaGridBlock extends StatelessWidget {
  static const MAX_CROSS_AXIS_EXTENT = SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 180.0,
    childAspectRatio: 0.5825,
  );

  final IconData posterPlaceholderIcon;
  final String posterUrl;
  final Map posterHeaders;
  final bool posterIsSquare;
  final String backgroundUrl;
  final Map backgroundHeaders;

  final bool disabled;
  final String title;
  final TextSpan subtitle;
  final Color titleColor;

  final Function onTap;
  final Function onLongPress;

  const LunaGridBlock({
    Key key,
    this.disabled = false,
    @required this.title,
    @required this.subtitle,
    this.titleColor = Colors.white,
    this.posterPlaceholderIcon,
    this.posterUrl,
    this.posterHeaders = const {},
    this.backgroundUrl,
    this.backgroundHeaders = const {},
    this.posterIsSquare = false,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaCard(
      context: context,
      margin: LunaUI.MARGIN_HALF,
      child: InkWell(
        child: Stack(
          children: [
            if (backgroundUrl?.isNotEmpty ?? false) _fadeInBackground(context),
            Opacity(
              opacity: disabled ? LunaUI.OPACITY_DISABLED : 1.0,
              child: Padding(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _poster(context),
                    _title(),
                    _subtitle(),
                    const SizedBox(height: LunaUI.MARGIN_SIZE_HALF),
                  ],
                ),
                padding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
        mouseCursor: onTap != null || onLongPress != null
            ? SystemMouseCursors.click
            : MouseCursor.defer,
        onTap: onTap,
        onLongPress: onLongPress,
      ),
    );
  }

  Widget _fadeInBackground(BuildContext context) {
    int _percent = LunaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY.data as int;
    if (_percent == 0) return const SizedBox(height: 0, width: 0);

    double _opacity = _percent / 100;
    if (disabled) _opacity *= LunaUI.OPACITY_DISABLED;

    return Opacity(
      opacity: _opacity,
      child: FadeInImage(
        placeholder: MemoryImage(kTransparentImage),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fadeInDuration: const Duration(
          milliseconds: LunaUI.ANIMATION_SPEED_IMAGES,
        ),
        fit: BoxFit.cover,
        image: CachedNetworkImageProvider(
          backgroundUrl,
          headers: backgroundHeaders?.cast<String, String>(),
          cacheManager: LunaImageCache.instance,
          errorListener: () {},
        ),
        imageErrorBuilder: (context, error, stack) => SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }

  Widget _poster(BuildContext context) {
    if (posterUrl == null && posterPlaceholderIcon == null) {
      throw Exception('Need a posterUrl or posterPlaceholderIcon');
    }

    return Flexible(
      child: Padding(
        child: LayoutBuilder(builder: (context, constraints) {
          double _dimension = constraints.maxWidth;
          return LunaNetworkImage(
            context: context,
            url: posterUrl ?? '',
            height: _dimension * 1.5,
            width: _dimension,
            headers: posterHeaders,
            placeholderIcon: posterPlaceholderIcon,
          );
        }),
        padding: LunaUI.MARGIN_HALF,
      ),
    );
  }

  Widget _title() {
    return Container(
      child: Padding(
        child: FadingEdgeScrollView.fromSingleChildScrollView(
          child: SingleChildScrollView(
            controller: ScrollController(),
            scrollDirection: Axis.horizontal,
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: LunaUI.FONT_SIZE_H3,
                  color: LunaColours.white,
                  fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                ),
                text: title,
              ),
              overflow: TextOverflow.visible,
              softWrap: false,
            ),
          ),
        ),
        padding: LunaUI.MARGIN_DEFAULT_HORIZONTAL,
      ),
      alignment: Alignment.centerLeft,
      height: LunaBlock.SUBTITLE_HEIGHT,
    );
  }

  Widget _subtitle() {
    return Container(
      child: Padding(
        child: FadingEdgeScrollView.fromSingleChildScrollView(
          child: SingleChildScrollView(
            controller: ScrollController(),
            scrollDirection: Axis.horizontal,
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: LunaUI.FONT_SIZE_H3,
                  color: LunaColours.grey,
                ),
                children: [subtitle],
              ),
              overflow: TextOverflow.visible,
              softWrap: false,
            ),
          ),
        ),
        padding: LunaUI.MARGIN_DEFAULT_HORIZONTAL,
      ),
      alignment: Alignment.centerLeft,
      height: LunaBlock.SUBTITLE_HEIGHT,
    );
  }
}
