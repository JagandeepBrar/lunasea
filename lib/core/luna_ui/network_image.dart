import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaNetworkImage extends ClipRRect {
    LunaNetworkImage({
        @required double height,
        @required double width,
        String url,
        @required String placeholderAsset,
        Map headers,
        bool roundCorners = true,
    }) : super(
        child: Container(
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
                        fadeInDuration: Duration(milliseconds: LunaUI().animationImageFadeInSpeed),
                        fadeOutDuration: Duration(milliseconds: 1),
                        placeholder: AssetImage(placeholderAsset),
                        fit: BoxFit.cover,
                        image: NetworkImage(url, headers: headers.cast<String, String>()),
                    ),
                ],
            ),
            height: height,
            width: width,
        ),
        borderRadius: roundCorners ? BorderRadius.circular(LunaUI().borderRadius) : null,
    ) {
        assert(height != null);
        assert(width != null);
        assert(placeholderAsset != null);
    }
}
