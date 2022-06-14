import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class LunaBottomModalSheet<T> {
  @protected
  Future<T?> showModal({
    Widget Function(BuildContext context)? builder,
  }) async {
    return showBarModalBottomSheet<T>(
      context: LunaState.navigatorKey.currentContext!,
      expand: false,
      backgroundColor:
          LunaTheme.isAMOLEDTheme ? Colors.black : LunaColours.secondary,
      shape: LunaUI.shapeBorder,
      builder: builder ?? this.builder as Widget Function(BuildContext),
      closeProgressThreshold: 0.90,
      elevation: LunaUI.ELEVATION,
    );
  }

  Widget? builder(BuildContext context) => null;

  Future<dynamic> show({
    Widget Function(BuildContext context)? builder,
  }) async =>
      showModal(builder: builder);
}
