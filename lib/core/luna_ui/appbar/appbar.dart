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
        ),
        centerTitle: false,
        elevation: 0,
        actions: actions,
        bottom: bottom,
    );
}

