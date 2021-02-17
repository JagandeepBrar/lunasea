import 'package:flutter/material.dart';

extension NavigatorStateExtension on NavigatorState {
    /// Safely pops the route by first checking that the route *can* be popped.
    /// 
    /// If the route can not be popped (it is the first/lowest route in the navigator), nothing occurs.
    void lunaSafetyPop() {
        if(this.canPop()) this.pop();
    }

    /// Pops every route until the route is the first/lowest route in the navigator.
    void lunaPopToFirst() {
        this.popUntil((route) => route.isFirst);
    }
}
