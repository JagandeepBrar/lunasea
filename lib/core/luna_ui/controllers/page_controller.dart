import 'package:flutter/material.dart';

class LunaPageController extends PageController {

    LunaPageController({
        int initialPage,
    }) : super(
        initialPage: initialPage,
    ) {
        this?.addListener(_focusListener);
    }

    void _focusListener() {
        FocusManager.instance.primaryFocus?.unfocus();
    }

    @override
    void dispose() {
        this?.removeListener(_focusListener);
        super.dispose();
    }
}