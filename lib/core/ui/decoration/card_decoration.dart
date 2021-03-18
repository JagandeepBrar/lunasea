import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

// ignore: non_constant_identifier_names
Decoration LunaCardDecoration({ @required String uri, @required Map headers }) {
    if(LunaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY.data == 0) return null;
    if(uri == null || uri.isEmpty) return BoxDecoration(borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS));
    return BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                uri,
                headers: Map<String, String>.from(headers),
            ),
            // To prevent excessive logs, just handle an error loading the image with an empty callback
            onError: (error, stack) {},
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity((LunaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY.data as int)/100),
                BlendMode.dstATop,
            ),
            fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
    );
}
