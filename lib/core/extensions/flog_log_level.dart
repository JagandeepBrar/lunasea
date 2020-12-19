import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:f_logs/f_logs.dart';

extension FLogLogLevelExtension on LogLevel {
    /// Return a readable string version of the log level.
    String get lunaName => this.toString().substring(9);

    /// Return a [Color] corresponding to the log level.
    Color get lunaColour {
        switch(this) {
            case LogLevel.WARNING: return LunaColours.orange;
            case LogLevel.ERROR: return LunaColours.red;
            case LogLevel.FATAL: return LunaColours.accent;
            default: return LunaColours.blueGrey;
        }
    }
}