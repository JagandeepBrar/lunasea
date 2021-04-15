import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaNetworkImage extends ClipRRect {
    LunaNetworkImage({
        double height,
        double width,
        String url,
        @required String placeholderAsset,
        Map headers,
        bool roundCorners = true,
    }) : super(
        child: Container(
            height: height,
            width: width,
            child: Stack(
                fit: StackFit.expand,
                children: [
                    Image.asset(
                        placeholderAsset,
                        height: height,
                        width: width,
                    ),
                    if(url != null && url.isNotEmpty) FadeInImage(
                        height: height,
                        width: width,
                        fadeInDuration: Duration(milliseconds: LunaUI.ANIMATION_IMAGE_FADE_IN_SPEED),
                        fadeOutDuration: Duration(milliseconds: 1),
                        placeholder: AssetImage(placeholderAsset),
                        fit: BoxFit.cover,
                        image: NetworkImage(url, headers: headers?.cast<String, String>()),
                        imageErrorBuilder: (context, error, stack) => Container(
                            height: height,
                            width: width,
                        ),
                    ),
                ],
            ),
        ),
        borderRadius: roundCorners ? BorderRadius.circular(LunaUI.BORDER_RADIUS) : null,
    ) {
        // assert(height != null);
        // assert(width != null);
        assert(placeholderAsset != null);
    }
}
