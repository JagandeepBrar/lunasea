import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaShapeBorder extends RoundedRectangleBorder {
  LunaShapeBorder({
    bool useBorder = false,
    bool topOnly = false,
  }) : super(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(LunaUI.BORDER_RADIUS),
            topRight: const Radius.circular(LunaUI.BORDER_RADIUS),
            bottomLeft: topOnly
                ? Radius.zero
                : const Radius.circular(LunaUI.BORDER_RADIUS),
            bottomRight: topOnly
                ? Radius.zero
                : const Radius.circular(LunaUI.BORDER_RADIUS),
          ),
          side: useBorder
              ? const BorderSide(color: LunaColours.white10)
              : BorderSide.none,
        );
}
