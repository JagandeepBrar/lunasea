import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaNetworkImage extends ClipRRect {
  LunaNetworkImage({
    Key? key,
    required BuildContext context,
    required double height,
    required double width,
    String? url,
    IconData? placeholderIcon,
    Map? headers,
  }) : super(
          key: key,
          child: SizedBox(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: height,
                  width: width,
                  child: Center(
                    child: placeholderIcon != null
                        ? Icon(
                            placeholderIcon,
                            color: LunaColours.accent,
                            size: width * 0.40,
                          )
                        : null,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
                    border: LunaUI.shouldUseBorder
                        ? Border.all(color: LunaColours.white10)
                        : null,
                  ),
                ),
                if (url?.isNotEmpty ?? false)
                  FadeInImage(
                    height: height,
                    width: width,
                    fadeInDuration: const Duration(
                      milliseconds: LunaUI.ANIMATION_SPEED_IMAGES,
                    ),
                    fadeOutDuration: const Duration(milliseconds: 1),
                    placeholder: MemoryImage(kTransparentImage),
                    fit: BoxFit.cover,
                    image: LunaNetworkImageProvider(
                      url: url!,
                      headers: headers?.cast<String, String>(),
                    ).imageProvider,
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
          borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
        );
}
