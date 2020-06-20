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
            top: false,
            child: Padding(
                child: GNav(
                    gap: 8.0,
                    iconSize: 24.0,
                    padding: EdgeInsets.fromLTRB(18.0, 5.0, 12.0, 5.0),
                    duration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
                    tabBackgroundColor: Theme.of(context).canvasColor,
                    activeColor: LSColors.accent,
                    tabs: List.generate(
                        icons.length,
                        (index) => GButton(
                            icon: icons[index],
                            text: titles[index],
                            iconSize: 22.0,
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                                color: LSColors.accent,
                            ),
                        )
                    ).toList(),
                    selectedIndex: index,
                    onTabChange: onTap,
                ),
                padding: EdgeInsets.all(12.0),
            ),
        ),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            //LSColors.secondary,
        ),
    );
}
