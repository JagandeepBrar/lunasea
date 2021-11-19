import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class LunaBottomModalSheet {
  /// Show a bottom modal sheet modal using the supplied builder to show the content.
  Future<dynamic> showModal({
    @required BuildContext context,
    @required Widget Function(BuildContext) builder,
  }) async =>
      showBarModalBottomSheet(
        context: context,
        expand: false,
        backgroundColor:
            LunaTheme.isAMOLEDTheme ? Colors.black : LunaColours.secondary,
        shape: LunaUI.shapeBorder,
        builder: builder,
        closeProgressThreshold: 0.90,
      );
}
