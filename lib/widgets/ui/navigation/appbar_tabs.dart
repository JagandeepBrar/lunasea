import 'package:flutter/material.dart';
import 'package:lunasea/core/constants.dart';
import 'package:lunasea/widgets.dart';

// ignore: non_constant_identifier_names
Widget LSAppBarTabs({
        @required String title,
        @required List<String> tabTitles
}) {
    return AppBar(
        title: Text(
            title,
            style: TextStyle(
                letterSpacing: Constants.UI_LETTER_SPACING,
            ),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: LSColors.secondary,
        bottom: TabBar(
            tabs: [
                for(int i=0; i<tabTitles.length; i++)
                    Tab(
                        child: Text(
                            tabTitles[i],
                            style: TextStyle(
                                letterSpacing: Constants.UI_LETTER_SPACING,
                            ),
                        ),
                    )
            ],
            isScrollable: true,
        ),
    );
}
