import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/system.dart';

// ignore: non_constant_identifier_names
Widget LSDrawerHeader() => UserAccountsDrawerHeader(
    accountName: StreamBuilder(
        stream: LunaFirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) => LSTitle(text: LunaFirebaseAuth().email ?? Constants.APPLICATION_NAME),
    ),
    accountEmail: ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [LunaDatabaseValue.ENABLED_PROFILE.key]),
        builder: (context, lunaBox, widget) => ValueListenableBuilder(
            valueListenable: Database.profilesBox.listenable(),
            builder: (context, profilesBox, widget) => Padding(
                child: LunaPopupMenuButton<String>(
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                            LSSubtitle(
                                text: LunaDatabaseValue.ENABLED_PROFILE.data,
                            ),
                            LSIcon(
                                icon: Icons.arrow_drop_down,
                                color: Colors.white70,
                                size: Constants.UI_FONT_SIZE_HEADER,
                            ),
                        ],
                    ),
                    onSelected: (result) {
                        HapticFeedback.selectionClick();
                        LunaProfile().safelyChangeProfiles(result);
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
        color: LunaColours.accent,
        image: DecorationImage(
            image: AssetImage('assets/branding/icon_drawer.png'),
            colorFilter: ColorFilter.mode(LunaColours.primary.withOpacity(0.15), BlendMode.dstATop),
            fit: BoxFit.cover,
        ),
    ),
);
