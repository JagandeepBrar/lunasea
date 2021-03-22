
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

/// Create a [LunaBottomActionBar] that contains button actions.
/// 
/// The children are expected to be [LunaButton]s or children of [LunaButton].
class LunaBottomActionBar extends StatelessWidget {
    final EdgeInsets padding;
    final List<Widget> actions;

    LunaBottomActionBar({
        @required this.actions,
        this.padding = const EdgeInsets.all(6.0),
        Key key,
    }) : super(key: key) {
        assert(actions != null && actions.length != 0);
    }

    @override
    Widget build(BuildContext context) {
        return Container(
            child: SafeArea(
                child: Padding(
                    child: LunaButtonContainer(
                        children: actions,
                        padding: EdgeInsets.zero,
                    ),
                    padding: padding,
                ),
            ),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
            ),
        );
    }
    
}