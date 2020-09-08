import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

// ignore: non_constant_identifier_names
Widget LSDrawerHeader() => UserAccountsDrawerHeader(
    accountName: LSTitle(text: Constants.APPLICATION_NAME),
    accountEmail: ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [LunaSeaDatabaseValue.ENABLED_PROFILE.key]),
        builder: (context, lunaBox, widget) => ValueListenableBuilder(
            valueListenable: Database.profilesBox.listenable(),
            builder: (context, profilesBox, widget) => Padding(
                child: PopupMenuButton<String>(
                    shape: LunaSeaDatabaseValue.THEME_AMOLED.data && LunaSeaDatabaseValue.THEME_AMOLED_BORDER.data
                        ? LSRoundedShapeWithBorder()
                        : LSRoundedShape(),
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                            LSSubtitle(
                                text: LunaSeaDatabaseValue.ENABLED_PROFILE.data,
                            ),
                            LSIcon(
                                icon: Icons.arrow_drop_down,
                                color: Colors.white70,
                                size: Constants.UI_FONT_SIZE_HEADER,
                            ),
                        ],
                    ),
                    onSelected: (result) {
                        LunaSeaDatabaseValue.ENABLED_PROFILE.put(result);
                        Providers.reset(context);
                        LSSnackBar(
                            context: context,
                            title: 'Changed Profile',
                            message: 'Using profile "$result"',
                            type: SNACKBAR_TYPE.info,
                        );
                    },
                    itemBuilder: (context) {
                        return <PopupMenuEntry<String>>[for(String profile in (profilesBox as Box).keys) PopupMenuItem<String>(
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
                padding: EdgeInsets.only(right: 12.0),
            ),
        ),
    ),
    decoration: BoxDecoration(
        color: LSColors.accent,
        image: DecorationImage(
            image: AssetImage('assets/branding/icon_drawer.png'),
            colorFilter: ColorFilter.mode(LSColors.primary.withOpacity(0.15), BlendMode.dstATop),
            fit: BoxFit.cover,
        ),
    ),
);
