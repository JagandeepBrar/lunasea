import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaNetworkImageBackground extends StatefulWidget {
  final bool disabled;
  final double height;

  final String? url;
  final Map? headers;

  const LunaNetworkImageBackground({
    super.key,
    required this.disabled,
    required this.height,
    required this.url,
    required this.headers,
  });

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<LunaNetworkImageBackground> {
  final _cancelToken = CancellationToken();

  @override
  void dispose() {
    if (!_cancelToken.isCanceled) _cancelToken.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.url?.isEmpty ?? true) {
      return _emptyImage();
    }

    final opacity = _calculateOpacity();
    if (opacity == 0) {
      return _emptyImage();
    }

    return Opacity(
      opacity: opacity,
      child: FadeInImage(
        placeholder: MemoryImage(kTransparentImage),
        height: widget.height,
        width: MediaQuery.of(context).size.width,
        fadeInDuration: const Duration(
          milliseconds: LunaUI.ANIMATION_SPEED_IMAGES,
        ),
        fit: BoxFit.cover,
        image: LunaNetworkImageProvider(
          url: widget.url!,
          headers: widget.headers?.cast<String, String>(),
          cancelToken: _cancelToken,
        ).imageProvider,
        imageErrorBuilder: (context, _, __) => SizedBox(
          height: widget.height,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }

  Widget _emptyImage() {
    return const SizedBox(
      height: 0,
      width: 0,
    );
  }

  double _calculateOpacity() {
    final percent = LunaSeaDatabase.THEME_IMAGE_BACKGROUND_OPACITY.read();
    if (percent == 0) return 0;

    double opacity = percent / 100;
    if (widget.disabled) opacity *= LunaUI.OPACITY_DISABLED;

    return opacity;
  }
}
