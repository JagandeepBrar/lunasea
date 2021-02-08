import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

enum _APPBAR_TYPE {
    DEFAULT,
    EMPTY,
    DROPDOWN,
}

class LunaAppBar extends StatelessWidget implements PreferredSizeWidget {
    final String title;
    final List<Widget> actions;
    final PreferredSizeWidget bottom;
    final bool useDrawer;
    final LunaModuleState state;
    final _APPBAR_TYPE type;
    final Widget child;
    final double height;
    final List<String> profiles;

    LunaAppBar._internal({
        @required this.type,
        @required this.useDrawer,
        this.title,
        this.actions,
        this.bottom,
        this.state,
        this.child,
        this.height,
        this.profiles,
    });

    /// Create a new [AppBar] widget pre-styled for LunaSea.
    /// 
    /// Wraps the [AppBar] in a [GestureDetector], and if a [LunaModuleState] instance is passed in, calls [scrollBackList] on tap.
    factory LunaAppBar({
        @required String title,
        List<Widget> actions,
        PreferredSizeWidget bottom,
        bool useDrawer = false,
        LunaModuleState state,
    }) {
        assert(title != null);
        return LunaAppBar._internal(
            title: title,
            actions: actions,
            bottom: bottom,
            useDrawer: useDrawer,
            state: state,
            type: _APPBAR_TYPE.DEFAULT,
        );
    }

    /// Create a new, empty [LunaAppBar] which can be used to attach to a [Scaffold] in a [PageView] that is already wrapped in an [AppBar].
    /// 
    /// Example usages would be a [PageView] but a single page needs an [AppBar] bottom widget.
    factory LunaAppBar.empty({
        @required Widget child,
        @required double height,
    }) {
        assert(child != null);
        assert(height != null);
        return LunaAppBar._internal(
            child: child,
            height: height,
            useDrawer: false,
            type: _APPBAR_TYPE.EMPTY,
        );
    }

    factory LunaAppBar.dropdown({
        @required String title,
        @required List<String> profiles,
        bool useDrawer = true,
        List<Widget> actions,
    }) {
        assert(title != null);
        assert(profiles != null);
        if(profiles == null || profiles.length < 2) return LunaAppBar._internal(
            title: title,
            actions: actions,
            useDrawer: useDrawer,
            type: _APPBAR_TYPE.DEFAULT,
        );
        return LunaAppBar._internal(
            title: title,
            profiles: profiles,
            actions: actions,
            useDrawer: useDrawer,
            type: _APPBAR_TYPE.DROPDOWN,
        );
    }

    @override
    Size get preferredSize => new Size.fromHeight(kToolbarHeight);

    @override
    Widget build(BuildContext context) {
        Widget child;
        switch(type) {
            case _APPBAR_TYPE.DEFAULT: child = _default(context); break;
            case _APPBAR_TYPE.EMPTY: child = _empty(context); break;
            case _APPBAR_TYPE.DROPDOWN: child = _dropdown(context); break;
            default: throw Exception('Unknown AppBar type.');
        }
        return GestureDetector(
            child: child,
            onTap: state?.scrollBackList,
        );
    }

    Widget _sharedLeading(BuildContext context) {
        if(useDrawer) return IconButton(
            icon: Icon(Icons.menu),
            onPressed: () async {
                HapticFeedback.lightImpact();
                if(Scaffold.of(context).hasDrawer) Scaffold.of(context).openDrawer();
            },
        );
        return InkWell(
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
        );
    }

    Widget _default(BuildContext context) {
        return AppBar(
            title: Text(
                title ?? '',
                overflow: TextOverflow.fade,
                style: TextStyle(fontSize: LunaUI().fontSizeAppBar),
            ),
            leading: _sharedLeading(context),
            centerTitle: false,
            elevation: 0,
            actions: actions,
            bottom: bottom,
        );
    }

    Widget _empty(BuildContext context) {
        return AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: height,
            leadingWidth: 0.0,
            elevation: 0.0,
            titleSpacing: 0.0,
            title: child,
        );
    }

    Widget _dropdown(BuildContext context) {
        return AppBar(
            title: PopupMenuButton<String>(
                shape: LunaUI().shapeBorder(),
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
            leading: _sharedLeading(context),
            centerTitle: false,
            elevation: 0,
            actions: actions,
        );
    }
}
