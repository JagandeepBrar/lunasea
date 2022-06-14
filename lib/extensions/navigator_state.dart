import 'package:flutter/material.dart';

extension NavigatorStateExtension on NavigatorState {
  void safetyPop() {
    if (this.canPop()) this.pop();
  }

  void popToRootRoute() {
    this.popUntil((route) => route.isFirst);
  }
}
