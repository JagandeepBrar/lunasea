import 'package:flutter/material.dart';

extension PageControllerExtension on PageController {
  Future<void> protectedJumpToPage(int index) async {
    if (this.hasClients) this.jumpToPage(index);
  }
}
