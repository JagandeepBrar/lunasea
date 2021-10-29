import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaDivider extends Divider {
  const LunaDivider({
    Key key,
  }) : super(
          key: key,
          thickness: 1.0,
          color: LunaColours.splash,
          indent: 60.0,
          endIndent: 60.0,
        );
}
