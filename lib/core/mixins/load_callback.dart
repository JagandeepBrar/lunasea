import 'package:flutter/material.dart';

/// Simple mixin to force a definition of [loadCallback], a post-frame callback added to the [initState] override.
mixin LunaLoadCallbackMixin<T extends StatefulWidget> on State<T> {
    @override
    void initState() {
        super.initState();
        WidgetsBinding.instance.addPostFrameCallback((_) => loadCallback());
    }

    Future<void> loadCallback();
}
