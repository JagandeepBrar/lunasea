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
          badgeColor:
              LunaColours.accent.withOpacity(LunaUI.OPACITY_BUTTON_BACKGROUND),
          elevation: 0,
          animationDuration:
              const Duration(milliseconds: LunaUI.ANIMATION_SPEED),
          animationType: BadgeAnimationType.scale,
          shape: BadgeShape.circle,
          position: BadgePosition.topEnd(
            top: -15,
            end: -15,
          ),
          badgeContent: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
          child: Icon(
            icon,
            color: isActive
                ? LunaColours.accent
                    .withOpacity(LunaUI.OPACITY_BUTTON_BACKGROUND)
                : Colors.white,
          ),
          showBadge: showBadge,
        );
}
