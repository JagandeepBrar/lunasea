import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/home.dart';

class LunaMessage extends StatelessWidget {
    final String text;
    final Color textColor;
    final String buttonText;
    final Function onTap;
    final bool useSafeArea;

    LunaMessage({
        Key key,
        @required this.text,
        this.textColor = Colors.white,
        this.buttonText,
        this.onTap,
        this.useSafeArea = true,
    }) {
        assert(text != null);
        if(buttonText != null) assert(onTap != null, 'onTap must be defined if buttonText is defined');
    }

    /// Return a message that is meant to be shown within a [ListView].
    factory LunaMessage.inList({
        Key key,
        @required String text,
        bool useSafeArea = false,
    }) {
        assert(text != null);
        return LunaMessage(
            key: key,
            text: text,
            useSafeArea: useSafeArea,
        );
    }

    /// Returns a centered message with a simple message, with a button to pop out of the route.
    factory LunaMessage.goBack({
        Key key,
        @required String text,
        @required BuildContext context,
        bool useSafeArea = true,
    }) {
        assert(context != null);
        return LunaMessage(
            key: key,
            text: text,
            buttonText: 'Go Back',
            onTap: () => Navigator.of(context).pop(),
            useSafeArea: useSafeArea,
        );
    }

    /// Return a pre-structured "An Error Has Occurred" message, with a "Try Again" button shown.
    factory LunaMessage.error({
        Key key,
        @required Function onTap,
        bool useSafeArea = true,
    }) {
        assert(onTap != null);
        return LunaMessage(
            key: key,
            text: 'An Error Has Occurred',
            buttonText: 'Try Again',
            onTap: onTap,
            useSafeArea: useSafeArea,
        );
    }

    /// Return a pre-structured "<module> Is Not Enabled" message, with a "Return Home" button shown.
    factory LunaMessage.moduleNotEnabled({
        Key key,
        @required BuildContext context,
        @required String module,
        bool useSafeArea = true,
    }) {
        assert(module != null);
        assert(context != null);
        return LunaMessage(
            key: key,
            text: '$module Is Not Enabled',
            buttonText: 'Return Home',
            onTap: () async => HomeConstants.MODULE_METADATA.launch(),
            useSafeArea: useSafeArea,
        );
    }

    @override
    Widget build(BuildContext context) {
        return SafeArea(
            top: useSafeArea,
            left: useSafeArea,
            right: useSafeArea,
            bottom: useSafeArea,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    Card(
                        margin: LunaUI.MARGIN_CARD,
                        elevation: LunaUI.ELEVATION,
                        shape: LunaUI.shapeBorder,
                        child: Row(
                            children: [
                                Expanded(
                                    child: Container(
                                        child: Text(
                                            text,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: textColor,
                                                fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                                                fontSize: LunaUI.FONT_SIZE_MESSAGES,
                                            ),
                                        ),
                                        margin: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
                                    ),
                                ),
                            ],
                        ),
                    ),
                    if(buttonText != null) LSButton(text: buttonText, onTap: onTap),
                ],
            ),
        );
    }
}