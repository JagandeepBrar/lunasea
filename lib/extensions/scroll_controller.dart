import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

extension ScrollControllerExtension on ScrollController {
  static const _duration =
      Duration(milliseconds: LunaUI.ANIMATION_SPEED_SCROLLING);
  static const _curve = Curves.easeInOutQuart;

  Future<void> animateToStart() async {
    if (this.hasClients) {
      this.animateTo(
        0.00,
        duration: _duration,
        curve: _curve,
      );
    }
  }

  Future<void> animateToOffset(double offset) async {
    if (this.hasClients) {
      return this.animateTo(
        offset,
        duration: _duration,
        curve: _curve,
      );
    }
  }
}
