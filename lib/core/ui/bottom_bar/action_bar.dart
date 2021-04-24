import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

/// Create a [LunaBottomActionBar] that contains button actions.
///
/// The children are expected to be [LunaButton]s or children of [LunaButton].
class LunaBottomActionBar extends StatelessWidget {
  final EdgeInsets padding;
  final List<Widget> actions;
  final bool useSafeArea;

  LunaBottomActionBar({
    @required this.actions,
    this.padding = const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
    this.useSafeArea = true,
    Key key,
  }) : super(key: key) {
    assert(actions?.isNotEmpty ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        top: useSafeArea,
        bottom: useSafeArea,
        left: useSafeArea,
        right: useSafeArea,
        child: Padding(
          child: LunaButtonContainer(
            children: actions,
            padding: EdgeInsets.zero,
          ),
          padding: padding,
        ),
      ),
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
    );
  }
}
