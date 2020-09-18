import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

// ignore: non_constant_identifier_names
Widget LSAppBar({
    @required String title,
    List<Widget> actions
}) => AppBar(
    title: Text(
        title,
        overflow: TextOverflow.fade,
        style: TextStyle(
            fontSize: Constants.UI_FONT_SIZE_HEADER,
        ),
    ),
    centerTitle: false,
    elevation: 0,
    actions: actions,
);
