import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:shimmer/shimmer.dart';

class LunaShimmer extends StatelessWidget {
  final Widget child;

  const LunaShimmer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: child,
      baseColor: Theme.of(context).primaryColor,
      highlightColor: LunaColours.accent,
    );
  }
}
