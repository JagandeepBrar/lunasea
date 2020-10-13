import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

// ignore: non_constant_identifier_names
Decoration LSCardBackground({ @required String uri, @required Map headers }) => BoxDecoration(
    image: DecorationImage(
        image: NetworkImage(
            uri,
            headers: Map<String, String>.from(headers),
        ),
        colorFilter: ColorFilter.mode(LunaColours.secondary.withOpacity(0.10), BlendMode.dstATop),
        fit: BoxFit.cover,
    ),
    borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
);
