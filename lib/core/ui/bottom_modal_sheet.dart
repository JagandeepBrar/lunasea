import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class LunaBottomModalSheet {
    /// Show a bottom modal sheet modal using the supplied builder to show the content.
    Future<dynamic> showModal({
        @required BuildContext context,
        @required Widget Function(BuildContext) builder,
        bool expand = true,
    }) async => showBarModalBottomSheet(
        context: context,
        expand: expand,
        backgroundColor: LunaDatabaseValue.THEME_AMOLED.data ? Colors.black : LunaColours.secondary,
        shape: LunaUI.shapeBorder,
        builder: builder,
    );
}
