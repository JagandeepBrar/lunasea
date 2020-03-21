import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LSBottomNavigationBar extends StatelessWidget {
    final int index;
    final Function onTap;
    final List<Icon> icons;
    final List<String> titles;

    LSBottomNavigationBar({
        @required this.index,
        @required this.onTap,
        @required this.icons,
        @required this.titles,
    });

    @override
    Widget build(BuildContext context) => BottomNavyBar(
        selectedIndex: index,
        onItemSelected: onTap,
        showElevation: false,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        backgroundColor: LSColors.primary,
        curve: Curves.easeInOut,
        items: [
            for(int i=0; i<icons.length; i++)
                BottomNavyBarItem(
                    textAlign: TextAlign.center,
                    icon: icons[i],
                    title: Text(titles[i]),
                    inactiveColor: Colors.white,
                    activeColor: LSColors.accent,
                )
        ],
    );
}
