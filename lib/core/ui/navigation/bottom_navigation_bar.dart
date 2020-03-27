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
    Widget build(BuildContext context) => Padding(
                padding: EdgeInsets.fromLTRB(11.0, 0.0, 11.0, 20.0),
                child: Container(
                    decoration: BoxDecoration(
                        color: LSColors.secondary,
                        borderRadius: BorderRadius.circular(28.0),
                        boxShadow: [
                            BoxShadow(
                                spreadRadius: 2.0,
                                blurRadius: 2.0,
                                color: Colors.black.withOpacity(0.10),
                            ),
                        ],
                    ),
                    child: Padding(
                        child: GNav(
                            gap: 8.0,
                            iconSize: 24.0,
                            padding: EdgeInsets.fromLTRB(18.0, 5.0, 12.0, 6.0),
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
                        padding: EdgeInsets.all(6.0),
                    ),
                ),
    );
}
