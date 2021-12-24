import 'package:flutter/material.dart';

extension PageControllerExtension on PageController {
  /// Jump a [PageView] to the given index.
  Future<void> lunaJumpToPage(int index) async {
    if (this.hasClients) this.jumpToPage(index);
  }
}
