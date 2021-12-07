import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaDivider extends Divider {
  const LunaDivider({
    Key key,
  }) : super(
          key: key,
          thickness: 1.0,
          color: LunaColours.splash,
          indent: LunaUI.DEFAULT_MARGIN_SIZE * 5,
          endIndent: LunaUI.DEFAULT_MARGIN_SIZE * 5,
        );
}
