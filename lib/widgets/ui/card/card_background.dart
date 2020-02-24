import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:lunasea/widgets.dart';

// ignore: non_constant_identifier_names
Decoration LSCardBackground({ @required String uri }) => BoxDecoration(
    image: DecorationImage(
        image: AdvancedNetworkImage(
            uri,
            useDiskCache: true,
            loadFailedCallback: () {},
            fallbackAssetImage: 'assets/images/secondary_color.png',
            retryLimit: 1,
        ),
        colorFilter: ColorFilter.mode(LSColors.secondary.withOpacity(0.20), BlendMode.dstATop),
        fit: BoxFit.cover,
    ),
    borderRadius: BorderRadius.circular(4.0),
);
