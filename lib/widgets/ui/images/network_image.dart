import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaNetworkImage extends StatefulWidget {
  final double width;
  final double height;

  final String? url;
  final Map? headers;
  final IconData? placeholderIcon;

  const LunaNetworkImage({
    super.key,
    required this.width,
    required this.height,
    this.url,
    this.headers,
    this.placeholderIcon,
  });

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<LunaNetworkImage> {
  final _cancelToken = CancellationToken();

  @override
  void dispose() {
    if (!_cancelToken.isCanceled) _cancelToken.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _placeholder(),
            _networkImage(),
          ],
        ),
      ),
    );
  }

  Widget _networkImage() {
    if (widget.url?.isEmpty ?? true) {
      return const SizedBox();
    }

    return FadeInImage(
      height: widget.height,
      width: widget.width,
      fadeInDuration: const Duration(
        milliseconds: LunaUI.ANIMATION_SPEED_IMAGES,
      ),
      fadeOutDuration: const Duration(milliseconds: 1),
      placeholder: MemoryImage(kTransparentImage),
      fit: BoxFit.cover,
      image: LunaNetworkImageProvider(
        url: widget.url!,
        headers: widget.headers?.cast<String, String>(),
        cancelToken: _cancelToken,
      ).imageProvider,
      imageErrorBuilder: (context, _, __) => SizedBox(
        height: widget.height,
        width: widget.width,
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
        border: LunaUI.shouldUseBorder
            ? Border.all(color: LunaColours.white10)
            : null,
      ),
      child: widget.placeholderIcon == null
          ? null
          : Icon(
              widget.placeholderIcon,
              color: LunaColours.accent,
              size: widget.width * 0.40,
            ),
    );
  }
}
