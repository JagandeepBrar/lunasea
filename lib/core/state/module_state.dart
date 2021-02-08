import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

abstract class LunaModuleState extends ChangeNotifier {
    /// [TrackingScrollController] to be used with all scrolling [ListView] (and similar scrolling widgets) within a module.
    final TrackingScrollController scrollController = TrackingScrollController();

    /// Using [scrollController], scrolls the first scroll position back to the beginning of the list.
    void scrollBackList() {
        if(scrollController.hasClients && scrollController.mostRecentlyUpdatedPosition != null) scrollController.mostRecentlyUpdatedPosition.animateTo(
            1.00,
            duration: Duration(milliseconds: LunaUI().uiNavigationSpeed*2),
            curve: Curves.easeOutSine
        );
    }

    @override
    void dispose() {
        scrollController?.dispose();
        super.dispose();
    }
    
    /// Reset the state back to the default
    void reset();

    /// Notify listeners of an update
    /// TODO: Remove this
    void notify() => notifyListeners();


}
