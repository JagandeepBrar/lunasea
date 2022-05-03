import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaTextSpan extends TextSpan {
  const LunaTextSpan.extended({
    required String? text,
  }) : super(
          text: text,
          style: const TextStyle(
            height: LunaBlock.SUBTITLE_HEIGHT / LunaUI.FONT_SIZE_H3,
          ),
        );
}
