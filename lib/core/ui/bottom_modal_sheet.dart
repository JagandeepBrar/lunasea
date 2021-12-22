import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class LunaBottomModalSheet {
  @protected
  Future<dynamic> showModal({
    @required BuildContext context,
    Widget Function(BuildContext context) builder,
  }) async {
    return showBarModalBottomSheet(
      context: context,
      expand: false,
      backgroundColor:
          LunaTheme.isAMOLEDTheme ? Colors.black : LunaColours.secondary,
      shape: LunaUI.shapeBorder,
      builder: builder ?? this.builder,
      closeProgressThreshold: 0.90,
      elevation: LunaUI.ELEVATION,
    );
  }

  Widget builder(BuildContext context) => null;

  Future<dynamic> show({
    @required BuildContext context,
    Widget Function(BuildContext context) builder,
  }) async =>
      showModal(
        context: context,
        builder: builder,
      );
}
