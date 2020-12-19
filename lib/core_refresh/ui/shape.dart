import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

// ignore: non_constant_identifier_names
ShapeBorder LSRoundedShape({
    double borderRadius = Constants.UI_BORDER_RADIUS,
}) => RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(borderRadius),
);

// ignore: non_constant_identifier_names
ShapeBorder LSRoundedShapeWithBorder({
    double borderRadius = Constants.UI_BORDER_RADIUS,
}) => RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(borderRadius),
    side: BorderSide(
        color: Colors.white12,
    ),
);
