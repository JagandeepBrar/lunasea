import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaNavigationBarBadge extends badges.Badge {
  LunaNavigationBarBadge({
    Key? key,
    required String text,
    required IconData icon,
    required bool showBadge,
    required bool isActive,
  }) : super(
          key: key,
          badgeStyle: badges.BadgeStyle(
            badgeColor: LunaColours.accent.dimmed(),
            elevation: LunaUI.ELEVATION,
            shape: badges.BadgeShape.circle,
          ),
          badgeAnimation: const badges.BadgeAnimation.scale(
            animationDuration:
                Duration(milliseconds: LunaUI.ANIMATION_SPEED_SCROLLING),
          ),
          position: badges.BadgePosition.topEnd(
            top: -LunaUI.DEFAULT_MARGIN_SIZE,
            end: -LunaUI.DEFAULT_MARGIN_SIZE,
          ),
          badgeContent: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
          child: Icon(
            icon,
            color: isActive ? LunaColours.accent : Colors.white,
          ),
          showBadge: showBadge,
        );
}
