import 'package:flutter/material.dart';

extension LunaAsyncSnapshotExtension on AsyncSnapshot {
  bool get lunaIsFinishedWithData {
    return this.connectionState == ConnectionState.done && this.hasData;
  }
}
