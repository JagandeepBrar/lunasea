export './navigation/appbar.dart';
export './navigation/drawer.dart';
export './navigation/bottom_navigation_bar.dart';

import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class Navigation {
    Navigation._();

    /*
     * getAppBarTabs(): Returns an AppBar widget with the passed in title and TabBar
     */
    static AppBar getAppBarTabs(String title, List<String> tabTitles, BuildContext context) {
        return AppBar(
            title: Text(
                title,
                style: TextStyle(
                    letterSpacing: Constants.LETTER_SPACING,
                ),
            ),
            centerTitle: false,
            elevation: 0,
            backgroundColor: Color(Constants.SECONDARY_COLOR),
            bottom: TabBar(
                tabs: [
                    for(int i =0; i<tabTitles.length; i++)
                        Tab(
                            child: Text(
                                tabTitles[i],
                                style: TextStyle(
                                    letterSpacing: Constants.LETTER_SPACING,
                                ),
                            )
                        )
                ],
                isScrollable: true,
            ),
        );
    }
}