import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LSBottomNavigationBar extends StatelessWidget {
    final int index;
    final Function onTap;
    final List<IconData> icons;
    final List<String> titles;

    LSBottomNavigationBar({
        @required this.index,
        @required this.onTap,
        @required this.icons,
        @required this.titles,
    });

    @override
    Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(color: LSColors.secondary),
        child: SafeArea(
            child: Padding(
                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 4.0),
                child: GNav(
                    gap: 0.0,
                    iconSize: 24.0,
                    padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
                    duration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
                    tabBackgroundColor: LSColors.accent,
                    tabs: List.generate(
                        icons.length,
                        (index) => GButton(
                            icon: icons[index],
                            text: titles[index],
                        )
                    ).toList(),
                    selectedIndex: index,
                    onTabChange: onTap,
                ),
            ),
        ),
    );
}
