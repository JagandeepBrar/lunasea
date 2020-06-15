import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget LSAppBar({
    @required String title,
    List<Widget> actions
}) => AppBar(
    title: Text(
        title,
        overflow: TextOverflow.fade,
    ),
    centerTitle: false,
    elevation: 0,
    actions: actions,
);
