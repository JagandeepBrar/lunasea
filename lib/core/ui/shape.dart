import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaShapeBorder extends RoundedRectangleBorder {
  LunaShapeBorder._internal({
    bool useBorder = false,
  }) : super(
          borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
          side: useBorder ? const BorderSide(color: Colors.white12) : BorderSide.none,
        );

  factory LunaShapeBorder.rounded() => LunaShapeBorder._internal();
  factory LunaShapeBorder.roundedWithBorder() =>
      LunaShapeBorder._internal(useBorder: true);
}
