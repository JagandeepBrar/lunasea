import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget LSAppBarTabs({
    @required String title,
    @required List<String> tabTitles
}) => AppBar(
    title: Text(title),
    centerTitle: false,
    elevation: 0,
    bottom: TabBar(
        tabs: [
            for(int i=0; i<tabTitles.length; i++)
                Tab(
                    child: Text(tabTitles[i]),
                )
        ],
        isScrollable: true,
    ),
);

