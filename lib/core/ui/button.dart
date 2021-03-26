import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

enum LunaButtonType {
    TEXT,
    ICON,
    LOADER,
}

/// A Luna-styled button.
class LunaButton extends Card {
    LunaButton._({
        Key key,
        @required Widget child,
        EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
        Color backgroundColor,
        double height = 50.0,
        Alignment alignment = Alignment.center,
        Decoration decoration,
        Function onTap,
        Function onLongPress,
        LunaLoadingState loadingState,
    }) : super(
        key: key,
        child: InkWell(
            child: Container(
                child: child,
                decoration: decoration,
                height: height,
                alignment: alignment,
            ),
            borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
            onTap: () async {
                HapticFeedback.lightImpact();
                if(onTap != null && loadingState != LunaLoadingState.ACTIVE) onTap();
            },
            onLongPress: () async {
                HapticFeedback.heavyImpact();
                if( onLongPress != null && loadingState != LunaLoadingState.ACTIVE) onLongPress();
            },
        ),
        margin: margin,
        color: backgroundColor != null
            ? backgroundColor
            : LunaTheme.isAMOLEDTheme ? Colors.black : LunaColours.primary,
        shape: LunaUI.shapeBorder,
        elevation: LunaUI.ELEVATION,
        clipBehavior: Clip.antiAlias,
    ) {
        assert(child != null);
    }

    /// Create a default button.
    /// 
    /// If [LunaLoadingState] is passed in, will build the correct button based on the type.
    factory LunaButton({
        @required LunaButtonType type,
        Color color = Colors.white,
        Color backgroundColor,
        String text,
        IconData icon,
        LunaLoadingState loadingState,
        EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
        double height = 50.0,
        Alignment alignment = Alignment.center,
        Decoration decoration,
        Function onTap,
        Function onLongPress,
    }) {
        assert(type != null);
        switch(loadingState) {
            case LunaLoadingState.ACTIVE: return LunaButton.loader(
                color: color,
                backgroundColor: backgroundColor,
                margin: margin,
                height: height,
                alignment: alignment,
                decoration: decoration,
                onTap: onTap,
                onLongPress: onLongPress,
            );
            case LunaLoadingState.ERROR: return LunaButton.icon(
                icon: Icons.error,
                color: color,
                backgroundColor: backgroundColor,
                margin: margin,
                height: height,
                alignment: alignment,
                decoration: decoration,
                onTap: onTap,
                onLongPress: onLongPress,
            );
            default: break;
        }
        switch(type) {
            case LunaButtonType.TEXT:
                assert(text != null);
                return LunaButton.text(
                    text: text,
                    icon: icon,
                    color: color,
                    backgroundColor: backgroundColor,
                    margin: margin,
                    height: height,
                    alignment: alignment,
                    decoration: decoration,
                    onTap: onTap,
                    onLongPress: onLongPress,
                );
            case LunaButtonType.ICON:
                assert(icon != null);
                return LunaButton.icon(
                    icon: icon,
                    color: color,
                    backgroundColor: backgroundColor,
                    margin: margin,
                    height: height,
                    alignment: alignment,
                    decoration: decoration,
                    onTap: onTap,
                    onLongPress: onLongPress,
                );
            case LunaButtonType.LOADER: return LunaButton.loader(
                color: color,
                backgroundColor: backgroundColor,
                margin: margin,
                height: height,
                alignment: alignment,
                decoration: decoration,
                onTap: onTap,
                onLongPress: onLongPress,
            );
        }
        throw Exception("Attempted to create an invalid LunaButton");
    }

    /// Build a button that contains a centered text string.
    factory LunaButton.text({
        @required String text,
        IconData icon,
        Color color = Colors.white,
        Color backgroundColor,
        EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
        double height = 50.0,
        Alignment alignment = Alignment.center,
        Decoration decoration,
        Function onTap,
        Function onLongPress,
    }) {
        return LunaButton._(
            child: Padding(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        if(icon != null) Padding(
                            child: Icon(
                                icon,
                                color: color,
                                size: 22.0,
                            ),
                            padding: EdgeInsets.only(right: 8.0),
                        ),
                        Flexible(
                            child: Text(
                                text,
                                style: TextStyle(
                                    color: color,
                                    fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                                    fontSize: LunaUI.FONT_SIZE_BUTTON,
                                ),
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                maxLines: 1,
                            ),
                        ),
                    ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.0),
            ),
            margin: margin,
            height: height,
            backgroundColor: backgroundColor,
            alignment: alignment,
            decoration: decoration,
            onTap: onTap,
            onLongPress: onLongPress,
        );
    }

    /// Build a button that contains a [LunaLoader].
    factory LunaButton.loader({
        EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
        Color color = Colors.white,
        Color backgroundColor = LunaColours.accent,
        double height = 50.0,
        Alignment alignment = Alignment.center,
        Decoration decoration,
        Function onTap,
        Function onLongPress,
    }) {
        return LunaButton._(
            child: LunaLoader(
                useSafeArea: false,
                color: color,
                size: 16.0,
            ),
            margin: margin,
            height: height,
            backgroundColor: backgroundColor,
            alignment: alignment,
            decoration: decoration,
            onTap: onTap,
            onLongPress: onLongPress,
        );
    }

    /// Build a button that contains a single, centered [Icon].
    factory LunaButton.icon({
        @required IconData icon,
        Color color = Colors.white,
        Color backgroundColor = LunaColours.accent,
        EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
        double height = 50.0,
        Alignment alignment = Alignment.center,
        Decoration decoration,
        Function onTap,
        Function onLongPress,
    }) {
        return LunaButton._(
            child: Icon(
                icon,
                color: color,
                size: 22.0,
            ),
            margin: margin,
            height: height,
            backgroundColor: backgroundColor,
            alignment: alignment,
            decoration: decoration,
            onTap: onTap,
            onLongPress: onLongPress,
        );
    }
}
