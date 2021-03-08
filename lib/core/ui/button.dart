import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

enum _BUTTON_SIZE {
    REGULAR,
    SLIM,
}

class LunaButton extends StatelessWidget {
    final Color textColor;
    final Color backgroundColor;
    final EdgeInsets margin;
    final LunaLoadingState loadingState;
    final Function onTap;
    final Function onLongPress;
    final String text;
    final Widget child;
    final _BUTTON_SIZE size;

    LunaButton._({
        Key key,
        @required this.onTap,
        @required this.onLongPress,
        @required this.size,
        @required this.text,
        @required this.child,
        @required this.textColor,
        @required this.backgroundColor,
        @required this.margin,
        @required this.loadingState,
    }) : super(key: key);

    /// Create a standard-sized button.
    factory LunaButton({
        Key key,
        @required Function onTap,
        Function onLongPress,
        String text = '',
        Widget child,
        Color textColor = Colors.white,
        Color backgroundColor = LunaColours.accent,
        EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
        LunaLoadingState loadingState = LunaLoadingState.INACTIVE,
    }) {
        return LunaButton._(
            key: key,
            onTap: onTap,
            onLongPress: onLongPress,
            text: text,
            child: child,
            textColor: textColor,
            backgroundColor: backgroundColor,
            margin: margin,
            loadingState: loadingState,
            size: _BUTTON_SIZE.REGULAR,
        );
    }

    /// Create a slim-sized button, typically used within table blocks.
    factory LunaButton.slim({
        Key key,
        @required Function onTap,
        Function onLongPress,
        String text = '',
        Widget child,
        Color textColor = Colors.white,
        Color backgroundColor = LunaColours.accent,
        EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
        LunaLoadingState loadingState = LunaLoadingState.INACTIVE,
    }) {
        return LunaButton._(
            key: key,
            onTap: onTap,
            onLongPress: onLongPress,
            text: text,
            child: child,
            textColor: textColor,
            backgroundColor: backgroundColor,
            margin: margin,
            loadingState: loadingState,
            size: _BUTTON_SIZE.SLIM,
        );
    }

    @override
    Widget build(BuildContext context) {
        return Row(
            children: [
                Expanded(
                    child: Card(
                        child: InkWell(
                            child: size == _BUTTON_SIZE.REGULAR ? _regular() : _slim(),
                            borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
                            onTap: () async {
                                HapticFeedback.lightImpact();
                                if(onTap != null && loadingState != LunaLoadingState.ACTIVE) onTap();
                            },
                            onLongPress: () async {
                                HapticFeedback.heavyImpact();
                                if(onLongPress != null && loadingState != LunaLoadingState.ACTIVE) onLongPress();
                            },
                        ),
                        margin: margin,
                        color: backgroundColor,
                        elevation: LunaUI.ELEVATION,
                        shape: LunaUI.shapeBorder,
                    ),
                ),
            ],
        );
    }

    Widget _regular() {
        return ListTile(title: _title());
    }

    Widget _slim() {
        return Padding(
            child: _title(),
            padding: EdgeInsets.symmetric(vertical: 14.0),
        );
    }

    Widget _title() {
        if(loadingState == LunaLoadingState.ACTIVE) return LunaLoader(
            useSafeArea: false,
            color: textColor,
            size: size == _BUTTON_SIZE.REGULAR ? 20.0 : 17.0,
        );
        if(loadingState == LunaLoadingState.ERROR) return Icon(
            Icons.error,
            color: textColor,
            size: size == _BUTTON_SIZE.REGULAR ? 20.0 : 17.0,
        );
        if(child != null) return child;
        return Text(
            text,
            style: TextStyle(
                color: textColor,
                fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                fontSize: LunaUI.FONT_SIZE_BUTTON,
            ),
            textAlign: TextAlign.center,
        );
    }
}