import 'package:flutter/material.dart';

abstract class LunaGlobalState extends ChangeNotifier {
    /// Reset the state back to the default
    void reset();

    /// Notify listeners of an update
    void notify() => notifyListeners();
}
