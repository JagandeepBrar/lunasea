import 'package:flutter/material.dart';
import 'package:lunasea/system/state.dart';
import 'package:lunasea/widgets/ui.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class LunaBottomModalSheet<T> {
  @protected
  Future<T?> showModal({
    Widget Function(BuildContext context)? builder,
  }) async {
    return showBarModalBottomSheet<T>(
      context: LunaState.context,
      expand: false,
      backgroundColor:
          LunaTheme.isAMOLEDTheme ? Colors.black : LunaColours.primary,
      shape: LunaShapeBorder(
        topOnly: true,
        useBorder: LunaUI.shouldUseBorder,
      ),
      builder: builder ?? this.builder as Widget Function(BuildContext),
      closeProgressThreshold: 0.90,
      elevation: LunaUI.ELEVATION,
      overlayStyle: LunaTheme().overlayStyle,
    );
  }

  Widget? builder(BuildContext context) => null;

  Future<dynamic> show({
    Widget Function(BuildContext context)? builder,
  }) async =>
      showModal(builder: builder);
}
