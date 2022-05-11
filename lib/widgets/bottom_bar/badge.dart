import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaNavigationBarBadge extends Badge {
  LunaNavigationBarBadge({
    Key? key,
    required String text,
    required IconData icon,
    required bool showBadge,
    required bool isActive,
  }) : super(
          key: key,
          badgeColor: LunaColours.accent.dimmed(),
          elevation: LunaUI.ELEVATION,
          animationDuration:
              const Duration(milliseconds: LunaUI.ANIMATION_SPEED_SCROLLING),
          animationType: BadgeAnimationType.scale,
          shape: BadgeShape.circle,
          position: BadgePosition.topEnd(
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
