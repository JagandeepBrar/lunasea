import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

// ignore: non_constant_identifier_names
Widget LSAppBar({
    @required String title,
    List<Widget> actions
}) => AppBar(
    title: Text(
        title,
        style: TextStyle(
            letterSpacing: Constants.UI_LETTER_SPACING,
        ),
    ),
    centerTitle: false,
    elevation: 0,
    backgroundColor: LSColors.secondary,
    actions: actions,
);
