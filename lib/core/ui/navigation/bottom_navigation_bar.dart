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
        child: SafeArea(
            child: Padding(
                child: GNav(
                    gap: 8.0,
                    iconSize: 24.0,
                    padding: EdgeInsets.fromLTRB(18.0, 5.0, 12.0, 5.0),
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
                padding: EdgeInsets.all(12.0),
            ),
        ),
        decoration: BoxDecoration(
            color: LSColors.secondary,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
        ),
    );
}
