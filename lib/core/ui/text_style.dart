import 'package:flutter/material.dart';

class LunaTextStyle extends TextStyle {
  const LunaTextStyle.labelMedium()
      : super(
          fontSize: 12.0, // md.sys.typescale.label-medium.size
          fontWeight: FontWeight.w500, // md.sys.typescale.label-medium.weight
          height: 16.0 / 12.0, // md.sys.typescale.label-medium.line-height
        );
}
