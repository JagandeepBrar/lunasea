import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaAppBar extends AppBar {
    LunaAppBar({
        @required BuildContext context,
        @required String title,
        @required String popUntil,
        List<Widget> actions,
        PreferredSizeWidget bottom,
        bool hideLeading = false,
    }) : super(
        title: Text(
            title ?? '',
            overflow: TextOverflow.fade,
            style: TextStyle(
                fontSize: LunaUI.FONT_SIZE_APPBAR,
            ),
        ),
        leading: hideLeading ? null : InkWell(
            child: Icon(Icons.arrow_back_ios),
            onTap: () async => Navigator.of(context).pop(),
            onLongPress: () async => popUntil == null
                ? Navigator.of(context).pop()
                : Navigator.of(context).popUntil(ModalRoute.withName(popUntil)),
            borderRadius: BorderRadius.circular(28.0),
        ),
        centerTitle: false,
        elevation: 0,
        actions: actions,
        bottom: bottom,
    );

    LunaAppBar.empty({
        @required Widget child,
        @required double height,
    }) : super(
        automaticallyImplyLeading: false,
        toolbarHeight: height,
        leadingWidth: 0.0,
        elevation: 0.0,
        titleSpacing: 0.0,
        title: child,
    );
}

