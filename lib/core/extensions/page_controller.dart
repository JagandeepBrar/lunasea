import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

extension PageControllerExtension on PageController {
    /// Animate a [PageView] back to 1.00, with a predefined duration and curve.
    Future<void> lunaAnimateToPage(int index) async {
        if(this.hasClients) this.animateToPage(
            index,
            duration: Duration(milliseconds: LunaUI.ANIMATION_SPEED),
            curve: Curves.decelerate,
        );
    }

    /// Jump a [PageView] to the given index.
    Future<void> lunaJumpToPage(int index) async {
        if(this.hasClients) this.jumpToPage(index);
    }
}
