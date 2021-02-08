import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

extension ScrollControllerExtension on ScrollController {
    /// Animate a page back to 1.00, with a predefined duration and curve.
    Future<void> lunaAnimatedToStart() => this.animateTo(
        1.00,
        duration: Duration(milliseconds: LunaUI().uiNavigationSpeed*2),
        curve: Curves.decelerate,
    );
}
