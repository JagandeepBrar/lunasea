import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

class LunaAppBar extends AppBar {
    /// Create a new [AppBar] widget pre-styled for LunaSea
    LunaAppBar({
        @required BuildContext context,
        @required String title,
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
            onTap: () async {
                HapticFeedback.lightImpact();
                Navigator.of(context).pop();
            },
            onLongPress: () async {
                HapticFeedback.heavyImpact();
                Navigator.of(context).popUntil((route) => route.isFirst);
            },
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

    factory LunaAppBar.dropdown({
        @required BuildContext context,
        @required String title,
        @required List<String> profiles,
        List<Widget> actions,
    }) {
        if(profiles == null || profiles.length < 2) return LunaAppBar(
            context: context,
            title: title,
            actions: actions,
            hideLeading: true,
        );
        return LunaAppBar._internalDropdown(
            context: context,
            title: title,
            actions: actions,
            profiles: profiles,
        );
    }

    LunaAppBar._internalDropdown({
        @required BuildContext context,
        @required String title,
        @required List<String> profiles,
        List<Widget> actions,
    }) : super(
        title: PopupMenuButton<String>(
            shape: LunaDatabaseValue.THEME_AMOLED.data && LunaDatabaseValue.THEME_AMOLED_BORDER.data
                ? LSRoundedShapeWithBorder()
                : LSRoundedShape(),
            child: Wrap(
                direction: Axis.horizontal,
                children: [
                    Text(
                        title,
                        style: TextStyle(
                            fontSize: Constants.UI_FONT_SIZE_HEADER,
                        ),
                    ),
                    LSIcon(
                        icon: Icons.arrow_drop_down,
                    ),
                ],
            ),
            onSelected: (result) {
                HapticFeedback.selectionClick();
                LunaProfile().safelyChangeProfiles(context, result);
            },
            itemBuilder: (context) {
                return <PopupMenuEntry<String>>[for(String profile in profiles) PopupMenuItem<String>(
                    value: profile,
                    child: Text(
                        profile,
                        style: TextStyle(
                            fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                        ),
                    ),
                )];
            },
        ),
        centerTitle: false,
        elevation: 0,
        actions: actions,
    );
}

