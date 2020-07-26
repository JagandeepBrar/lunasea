import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lunasea/core.dart';

// ignore: non_constant_identifier_names
Decoration LSCardBackground({ @required String uri, @required Map headers, bool darken = false }) => BoxDecoration(
    image: DecorationImage(
        image: CachedNetworkImageProvider(
            uri,
            headers: Map<String, String>.from(headers),
        ),
        colorFilter: ColorFilter.mode(LSColors.secondary.withOpacity(darken ? 0.10 : 0.20), BlendMode.dstATop),
        fit: BoxFit.cover,
    ),
    borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
);
