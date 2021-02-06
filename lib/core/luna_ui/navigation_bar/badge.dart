import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaNavigationBarBadge extends Badge {
    LunaNavigationBarBadge({
        Key key,
        @required String text,
        @required IconData icon,
        @required bool showBadge,
        @required bool isActive,
    }) : super(
        key: key,
        badgeColor: LunaColours.accent,
        elevation: 0,
        animationDuration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
        animationType: BadgeAnimationType.fade,
        shape: BadgeShape.circle,
        position: BadgePosition.topEnd(
            top: -15,
            end: -15,
        ),
        badgeContent: Text(
            text,
            style: TextStyle(color: Colors.white),
        ),
        child: Icon(
            icon,
            color: isActive ? LunaColours.accent : Colors.white,
        ),
        showBadge: showBadge,
    );
}