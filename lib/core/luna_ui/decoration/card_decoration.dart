import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

// ignore: non_constant_identifier_names
Decoration LunaCardDecoration({ @required String uri, @required Map headers }) {
    if(LunaSeaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY.data == 0) return null;
    double _opacity = (LunaSeaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY.data as int)/100;
    return BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                uri,
                headers: Map<String, String>.from(headers),
            ),
            onError: (error, stack) => LunaLogger.warning(
                'LunaCardDecoration',
                'DecorationImage',
                'Failed to fetch background image: $uri',
            ),
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(_opacity), BlendMode.dstATop),
            fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
    );
}
