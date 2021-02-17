import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

abstract class LunaModuleState extends ChangeNotifier {
    /// [ScrollController] to be used with all scrolling [ListView] (and similar scrolling widgets) within a module.
    final ScrollController scrollController = ScrollController();

    /// Using [scrollController], scrolls the first scroll position back to the beginning of the list.
    Future<void> scrollBackList() => scrollController.lunaAnimateToStart();

    @override
    void dispose() {
        scrollController?.dispose();
        super.dispose();
    }
    
    /// Reset the state back to the default
    void reset();
}
