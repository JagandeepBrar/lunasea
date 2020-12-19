import 'package:flutter/material.dart';

abstract class LunaModuleState extends ChangeNotifier {
    /// Reset the state back to the default
    void reset();

    /// Notify listeners of an update
    void notify() => notifyListeners();
}
