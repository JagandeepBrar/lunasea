import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaBlock extends StatelessWidget {
  static const TITLE_HEIGHT = LunaUI.FONT_SIZE_H2 + 4.0;
  static const SUBTITLE_HEIGHT = LunaUI.FONT_SIZE_H3 + 4.0;

  // If true, will load a skeleton-form version of the block.
  final bool skeletonEnabled;
  final bool skeletonPoster;
  final int skeletonSubtitles;

  final bool? disabled;
  final String? title;
  final Color titleColor;
  final Color? backgroundColor;

  /// If defined, only takes the first body subtitle from the [body] array
  /// And allows that single [TextSpan] to overflow to this many lines
  final int? customBodyMaxLines;
  final List<TextSpan>? body;

  /// Icons that lead the body lines. If defined, then the length of this list
  /// must match the length of [body]. If a specific line does not need a
  /// leading icon, pass in null.
  final List<IconData?>? bodyLeadingIcons;
  final Color bodyLeadingIconsColor;

  final Widget? leading;
  final Widget? trailing;
  final Widget? bottom;
  final double bottomHeight;

  final Function? onTap;
  final Function? onLongPress;

  final IconData? posterPlaceholderIcon;
  final String? posterUrl;
  final Map? posterHeaders;
  final bool posterIsSquare;
  final String? backgroundUrl;
  final Map? backgroundHeaders;

  const LunaBlock({
    Key? key,
    this.skeletonEnabled = false,
    this.skeletonPoster = true,
    this.skeletonSubtitles = 2,
    this.disabled = false,
    this.title,
    this.titleColor = Colors.white,
    this.backgroundColor,
    this.body,
    this.bodyLeadingIcons,
    this.bodyLeadingIconsColor = LunaColours.accent,
    this.bottom,
    this.bottomHeight = SUBTITLE_HEIGHT,
    this.customBodyMaxLines,
    this.posterPlaceholderIcon,
    this.posterUrl,
    this.posterHeaders = const {},
    this.posterIsSquare = false,
    this.backgroundUrl,
    this.backgroundHeaders = const {},
    this.onTap,
    this.onLongPress,
    this.leading,
    this.trailing,
  }) : super(key: key);

  static double calculateItemExtent(
    int subtitleLines, {
    bool hasBottom = false,
    double bottomHeight = SUBTITLE_HEIGHT,
  }) {
    double height = calculateItemHeight(
      subtitleLines,
      hasBottom: hasBottom,
      bottomHeight: bottomHeight,
    );
    return height + LunaUI.MARGIN_H_DEFAULT_V_HALF.vertical;
  }

  static double calculateItemHeight(
    int subtitleLines, {
    bool hasBottom = false,
    double bottomHeight = SUBTITLE_HEIGHT,
  }) {
    double height = (LunaUI.DEFAULT_MARGIN_SIZE * 2) + TITLE_HEIGHT;
    height += subtitleLines * SUBTITLE_HEIGHT;
    if (hasBottom) height += bottomHeight;
    return height;
  }

  double _calculateHeight() {
    int? _scalar = customBodyMaxLines;
    _scalar ??= body?.length ?? 0;
    return calculateItemHeight(
      _scalar,
      hasBottom: bottom != null,
      bottomHeight: bottomHeight,
    );
  }

  double _calculateSkeletonHeight() {
    return calculateItemHeight(
      skeletonSubtitles,
      hasBottom: bottom != null,
      bottomHeight: bottomHeight,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (skeletonEnabled) return _buildSkeletonBlock(context);
    return _buildBlock(context);
  }

  Widget _buildSkeletonBlock(BuildContext context) {
    double _height = _calculateSkeletonHeight();
    return LunaCard(
      context: context,
      child: LunaShimmer(
        child: Row(
          children: [
            if (skeletonPoster) _poster(context, _height),
            _tile(context, _height),
          ],
        ),
      ),
      height: _height,
    );
  }

  Widget _buildBlock(BuildContext context) {
    double _height = _calculateHeight();
    return LunaCard(
      context: context,
      child: InkWell(
        child: Stack(
          children: [
            if (backgroundUrl?.isNotEmpty ?? false)
              _fadeInBackground(context, _height),
            Opacity(
              opacity: disabled! ? LunaUI.OPACITY_DISABLED : 1.0,
              child: Row(
                children: [
                  _poster(context, _height),
                  _tile(context, _height),
                ],
              ),
            ),
          ],
        ),
        mouseCursor: onTap != null || onLongPress != null
            ? SystemMouseCursors.click
            : MouseCursor.defer,
        onTap: onTap as void Function()?,
        onLongPress: onLongPress as void Function()?,
      ),
      height: _height,
      color: backgroundColor,
    );
  }

  Widget _fadeInBackground(BuildContext context, double _height) {
    if (backgroundUrl == null) return const SizedBox();

    final _percent = LunaSeaDatabase.THEME_IMAGE_BACKGROUND_OPACITY.read();
    if (_percent == 0) return const SizedBox(height: 0, width: 0);

    double _opacity = _percent / 100;
    if (disabled!) _opacity *= LunaUI.OPACITY_DISABLED;

    return Opacity(
      opacity: _opacity,
      child: FadeInImage(
        placeholder: MemoryImage(kTransparentImage),
        height: _height,
        width: MediaQuery.of(context).size.width,
        fadeInDuration: const Duration(
          milliseconds: LunaUI.ANIMATION_SPEED_IMAGES,
        ),
        fit: BoxFit.cover,
        image: LunaNetworkImageProvider(
          url: backgroundUrl!,
          headers: backgroundHeaders?.cast<String, String>(),
        ).imageProvider,
        imageErrorBuilder: (context, error, stack) => SizedBox(
          height: _height,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }

  Widget _poster(BuildContext context, double height) {
    double _dimension = height - LunaUI.DEFAULT_MARGIN_SIZE;

    if (skeletonEnabled) {
      return Padding(
        padding: const EdgeInsets.only(left: LunaUI.MARGIN_SIZE_HALF),
        child: Container(
          height: _dimension,
          width: _dimension / (posterIsSquare ? 1.0 : 1.5),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
            border: LunaUI.shouldUseBorder
                ? Border.all(color: LunaColours.white10)
                : null,
          ),
        ),
      );
    }

    if (posterUrl == null && posterPlaceholderIcon == null) {
      return const SizedBox(width: 0.0, height: 0.0);
    }

    return Padding(
      padding: const EdgeInsets.only(left: LunaUI.MARGIN_SIZE_HALF),
      child: LunaNetworkImage(
        context: context,
        url: posterUrl ?? '',
        headers: posterHeaders,
        placeholderIcon: posterPlaceholderIcon,
        height: _dimension,
        width: _dimension / (posterIsSquare ? 1.0 : 1.5),
      ),
    );
  }

  Widget _tile(BuildContext context, double height) {
    if (skeletonEnabled) {
      return Expanded(
        child: Padding(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: LunaBlock.TITLE_HEIGHT - 4.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
                  border: LunaUI.shouldUseBorder
                      ? Border.all(color: LunaColours.white10)
                      : null,
                ),
              ),
              ...List.generate(skeletonSubtitles, (_) {
                return Container(
                  height: LunaBlock.SUBTITLE_HEIGHT - 6.0,
                  width: MediaQuery.of(context).size.width / 2.5,
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
                    border: LunaUI.shouldUseBorder
                        ? Border.all(color: LunaColours.white10)
                        : null,
                  ),
                );
              }),
            ],
          ),
          padding: LunaUI.MARGIN_DEFAULT,
        ),
      );
    }

    return Expanded(
      // ignore: deprecated_member_use_from_same_package
      child: LunaListTile(
        context: context,
        title: _scrollableText(
          child: LunaText.title(
            text: title ?? LunaUI.TEXT_EMDASH,
            color: titleColor,
            overflow: TextOverflow.visible,
            maxLines: 1,
          ),
        ),
        subtitle: _subtitle(),
        color: Colors.transparent,
        margin: EdgeInsets.zero,
        drawBorder: false,
        height: height,
        trailing: trailing,
        leading: leading,
      ),
    );
  }

  Widget? _subtitle() {
    int maxLines = customBodyMaxLines ?? 1;
    double height = SUBTITLE_HEIGHT * maxLines;

    if (bodyLeadingIcons != null) {
      assert(
        bodyLeadingIcons!.length == body?.length,
        'bodyLeadingIcons and body should be the same size',
      );
    }

    Widget _wrapper(List<Widget> children) {
      return Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      );
    }

    Widget _entry(TextSpan textSpan, IconData? icon) {
      return SizedBox(
        height: height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null)
              Padding(
                child: Container(
                  child: Icon(
                    icon,
                    color: bodyLeadingIconsColor,
                    size: LunaUI.FONT_SIZE_H2,
                  ),
                  height: SUBTITLE_HEIGHT * maxLines,
                  width: SUBTITLE_HEIGHT,
                  alignment: Alignment.centerLeft,
                ),
                padding: const EdgeInsets.only(
                  right: LunaUI.DEFAULT_MARGIN_SIZE / 4,
                ),
              ),
            Expanded(
              child: _scrollableText(
                scrollDirection: maxLines > 1 ? Axis.vertical : Axis.horizontal,
                child: Container(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: LunaUI.FONT_SIZE_H3,
                        color: LunaColours.grey,
                      ),
                      children: [textSpan],
                    ),
                    overflow: TextOverflow.ellipsis,
                    softWrap: maxLines == 1 ? false : true,
                    maxLines: maxLines,
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
          ],
        ),
      );
    }

    List<Widget> _children = [];

    if (body?.isNotEmpty ?? false) {
      if (customBodyMaxLines != null) {
        _children.add(_entry(body![0], bodyLeadingIcons?.elementAtOrNull(0)));
      } else {
        for (int i = 0; i < body!.length; i++) {
          _children.add(_entry(body![i], bodyLeadingIcons?.elementAtOrNull(i)));
        }
      }
    }

    if (bottom != null) {
      _children.add(SizedBox(
        height: bottomHeight,
        child: bottom,
      ));
    }

    return _children.isEmpty ? null : _wrapper(_children);
  }

  Widget _scrollableText({
    required Widget child,
    Axis scrollDirection = Axis.horizontal,
  }) {
    return SingleChildScrollView(
      scrollDirection: scrollDirection,
      child: child,
    );
  }
}
