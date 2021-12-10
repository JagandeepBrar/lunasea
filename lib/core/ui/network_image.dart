import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaNetworkImage extends ClipRRect {
  LunaNetworkImage({
    Key key,
    double height,
    double width,
    String url,
    @required String placeholderAsset,
    Map headers,
    bool roundCorners = true,
  }) : super(
          key: key,
          child: SizedBox(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  placeholderAsset,
                  height: height,
                  width: width,
                  isAntiAlias: true,
                ),
                if (url != null && url.isNotEmpty)
                  FadeInImage(
                    height: height,
                    width: width,
                    fadeInDuration: const Duration(
                      milliseconds: LunaUI.ANIMATION_IMAGE_FADE_IN_SPEED,
                    ),
                    fadeOutDuration: const Duration(milliseconds: 1),
                    placeholder: AssetImage(placeholderAsset),
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      url,
                      headers: headers?.cast<String, String>(),
                    ),
                    imageErrorBuilder: (context, error, stack) => SizedBox(
                      height: height,
                      width: width,
                    ),
                  ),
              ],
            ),
            height: height,
            width: width,
          ),
          clipBehavior: Clip.antiAlias,
          borderRadius:
              roundCorners ? BorderRadius.circular(LunaUI.BORDER_RADIUS) : null,
        ) {
    // assert(height != null);
    // assert(width != null);
    assert(placeholderAsset != null);
  }
}
