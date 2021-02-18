import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

enum _APPBAR_TYPE {
    DEFAULT,
    EMPTY,
    DROPDOWN,
}

class LunaAppBar extends StatefulWidget implements PreferredSizeWidget {
    final _APPBAR_TYPE type;
    final String title;
    final List<Widget> actions;
    final PreferredSizeWidget bottom;
    final bool useDrawer;
    final Widget child;
    final double height;
    final List<String> profiles;
    final PageController pageController;
    final List<ScrollController> scrollControllers;

    @override
    Size get preferredSize {
        double _size = kToolbarHeight+6.0;
        if(bottom != null) _size += bottom.preferredSize.height;
        return new Size.fromHeight(_size);
    }

    LunaAppBar._internal({
        @required this.type,
        @required this.useDrawer,
        this.title,
        this.actions,
        this.bottom,
        this.child,
        this.height,
        this.profiles,
        this.pageController,
        this.scrollControllers,
    });

    /// Create a new [AppBar] widget pre-styled for LunaSea.
    /// 
    /// Will register an onTap gesture for the AppBar if:
    /// - [state] is supplied, and will call [scrollBackList] on the state controller.
    /// - [pageController] and [scrollControllers] are supplied, will register a listener on the page controller and scroll back the respective scroll controller.
    /// 
    /// Passing in all 3 will result in state.scrollBackList taking precedence.
    factory LunaAppBar({
        @required String title,
        List<Widget> actions,
        PreferredSizeWidget bottom,
        bool useDrawer = false,
        PageController pageController,
        List<ScrollController> scrollControllers,
    }) {
        assert(title != null);
        if(pageController != null) assert(scrollControllers != null, 'pageController is defined, scrollControllers should as well.');
        return LunaAppBar._internal(
            title: title,
            actions: actions,
            bottom: bottom,
            useDrawer: useDrawer,
            pageController: pageController,
            scrollControllers: scrollControllers,
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

    /// Create a [lunaAppBar] with the title widget having a dropdown to switch to the supplied list of profiles.
    ///
    /// Will register an onTap gesture for the AppBar if:
    /// - [state] is supplied, and will call [scrollBackList] on the state controller.
    /// - [pageController] and [scrollControllers] are supplied, will register a listener on the page controller and scroll back the respective scroll controller.
    /// 
    /// Passing in all 3 will result in state.scrollBackList taking precedence.
    factory LunaAppBar.dropdown({
        @required String title,
        @required List<String> profiles,
        bool useDrawer = true,
        List<Widget> actions,
        PageController pageController,
        List<ScrollController> scrollControllers,
    }) {
        assert(title != null);
        assert(profiles != null);
        if(pageController != null) assert(scrollControllers != null, 'if pageController is defined, scrollControllers should as well.');
        if(profiles == null || profiles.length < 2) return LunaAppBar._internal(
            title: title,
            actions: actions,
            useDrawer: useDrawer,
            pageController: pageController,
            scrollControllers: scrollControllers,
            type: _APPBAR_TYPE.DEFAULT,
        );
        return LunaAppBar._internal(
            title: title,
            profiles: profiles,
            actions: actions,
            useDrawer: useDrawer,
            pageController: pageController,
            scrollControllers: scrollControllers,
            type: _APPBAR_TYPE.DROPDOWN,
        );
    }

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<LunaAppBar> {
    int _index;

    @override
    void initState() {
        _index = widget.pageController?.initialPage ?? 0;
        widget.pageController?.addListener(_pageControllerListener);
        super.initState();
    }

    @override
    void dispose() {
        widget.pageController?.removeListener(_pageControllerListener);
        super.dispose();
    }

    void _pageControllerListener() {
        if((widget.pageController?.page?.round() ?? _index) == _index) return;
        _index = widget.pageController.page.round();
    }

    void _onTap() {
        try {
            if(
                widget.scrollControllers != null &&                 // Ensure that the array isn't null
                widget.scrollControllers.length != 0 &&             // Ensure that there is at least one scroll controller
                (widget.scrollControllers.length-1) >= _index &&    // Ensure that the index isn't outside of the array bounds
                widget.scrollControllers[_index] != null            // Ensure that the scroll controller at the position isn't null
            ) widget.scrollControllers[_index]?.lunaAnimateToStart();
        } catch (error, stack) {
            LunaLogger().error('Failed to scroll back: Index: $_index, ScrollControllers: ${widget.scrollControllers?.length ?? 0}', error, stack);
        }
    }
    
    @override
    Widget build(BuildContext context) {
        Widget child;
        switch(widget.type) {
            case _APPBAR_TYPE.DEFAULT: child = _default(context); break;
            case _APPBAR_TYPE.EMPTY: child = _empty(context); break;
            case _APPBAR_TYPE.DROPDOWN: child = _dropdown(context); break;
            default: throw Exception('Unknown AppBar type.');
        }
        return GestureDetector(
            child: child,
            // TODO
            onTap: _onTap,
        );
    }

    Widget _sharedLeading(BuildContext context) {
        if(widget.useDrawer) return IconButton(
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
                Navigator.of(context).lunaSafetyPop();
            },
            onLongPress: () async {
                HapticFeedback.heavyImpact();
                Navigator.of(context).lunaPopToFirst();
            },
            borderRadius: BorderRadius.circular(28.0),
        );
    }

    Widget _default(BuildContext context) {
        return AppBar(
            title: Text(
                widget.title ?? '',
                overflow: TextOverflow.fade,
                style: TextStyle(fontSize: LunaUI.FONT_SIZE_APP_BAR),
            ),
            leading: _sharedLeading(context),
            centerTitle: false,
            elevation: 0,
            actions: widget.actions,
            bottom: widget.bottom,
        );
    }

    Widget _empty(BuildContext context) {
        return AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: widget.height,
            leadingWidth: 0.0,
            elevation: 0.0,
            titleSpacing: 0.0,
            title: widget.child,
        );
    }

    Widget _dropdown(BuildContext context) {
        return AppBar(
            title: LunaPopupMenuButton<String>(
                child: Wrap(
                    direction: Axis.horizontal,
                    children: [
                        Text(
                            widget.title,
                            style: TextStyle(fontSize: Constants.UI_FONT_SIZE_HEADER),
                        ),
                        LSIcon(icon: Icons.arrow_drop_down),
                    ],
                ),
                onSelected: (result) {
                    HapticFeedback.selectionClick();
                    LunaProfile().safelyChangeProfiles(result);
                },
                itemBuilder: (context) {
                    return <PopupMenuEntry<String>>[for(String profile in widget.profiles) PopupMenuItem<String>(
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
            actions: widget.actions,
        );
    }
}
