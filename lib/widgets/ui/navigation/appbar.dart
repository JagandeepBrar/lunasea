import 'package:flutter/material.dart';
import 'package:lunasea/core/constants.dart';
import 'package:lunasea/widgets.dart';

// ignore: non_constant_identifier_names
Widget LSAppBar(String title) {
    return AppBar(
        title: Text(
            title,
            style: TextStyle(
                letterSpacing: Constants.LETTER_SPACING,
            ),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: LSColors.secondary,
    );
}
