import 'package:flutter/material.dart';

/// Re-definition of [PageController] that adds a listener that will unfocus primary focus on a page change.
///
/// Needed for situations that a page has a keyboard prompt to unfocus the keyboard.
class LunaPageController extends PageController {
  LunaPageController({
    int? initialPage,
  }) : super(
          initialPage: initialPage ?? 0,
        ) {
    this.addListener(_focusListener);
  }

  void _focusListener() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void dispose() {
    this.removeListener(_focusListener);
    super.dispose();
  }
}
