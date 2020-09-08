import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

// ignore: non_constant_identifier_names
Widget LSNetworkImage({
    @required double height,
    @required double width,
    @required String url,
    @required String placeholder,
    Map<String, String> headers,
    bool roundCorners = true,
}) => ClipRRect(
    child: Container(
        child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
                Image.asset(placeholder),
                FadeInImage(
                    height: height,
                    width: width,
                    fadeInDuration: Duration(milliseconds: Constants.UI_IMAGE_FADEIN_SPEED),
                    fadeOutDuration: Duration(milliseconds: 1),
                    placeholder: AssetImage(placeholder),
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        url,
                        headers: headers,
                    ),
                ),
            ],
        ),
        height: height,
        width: width,
    ),
    borderRadius: roundCorners
        ? BorderRadius.circular(Constants.UI_BORDER_RADIUS)
        : null,
);