import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

extension ScrollControllerExtension on ScrollController {
  /// Animate a [Scrollable] back to 1.00, with a predefined duration and curve.
  Future<void> lunaAnimateToStart() async {
    if (this.hasClients)
      this.animateTo(
        0.00,
        duration: const Duration(milliseconds: LunaUI.ANIMATION_SPEED * 2),
        curve: Curves.easeInOutQuart,
      );
  }
}
