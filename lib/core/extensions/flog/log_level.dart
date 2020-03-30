import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:f_logs/f_logs.dart' as FLog;

extension FLogLogLevelExtension on FLog.LogLevel {
    //ignore: non_constant_identifier_names
    String lsFLogLogLevel_name() => this.toString().substring(9);

    //ignore: non_constant_identifier_names
    Color lsFLogLogLevel_color() {
        switch(this.toString()) {
            case 'LogLevel.WARNING': return Colors.orange;
            case 'LogLevel.ERROR': return Colors.red;
            case 'LogLevel.FATAL': return LSColors.accent;
            default: return Colors.blueGrey;
        }
    }
}