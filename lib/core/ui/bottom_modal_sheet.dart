import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class LunaBottomModalSheet {
  Future<dynamic> showModal({
    @required BuildContext context,
    Widget Function(BuildContext) builder,
  }) async =>
      showBarModalBottomSheet(
        context: context,
        expand: false,
        backgroundColor:
            LunaTheme.isAMOLEDTheme ? Colors.black : LunaColours.secondary,
        shape: LunaUI.shapeBorder,
        builder: this.builder ?? builder,
        closeProgressThreshold: 0.90,
      );

  Widget builder(BuildContext context) => null;
}
