import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lunasea/core.dart';

class LunaLoader extends StatelessWidget {
  final double size;
  final Color? color;
  final bool useSafeArea;

  const LunaLoader({
    Key? key,
    this.size = 25.0,
    this.color,
    this.useSafeArea = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
        left: useSafeArea,
        right: useSafeArea,
        top: useSafeArea,
        bottom: useSafeArea,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SpinKitThreeBounce(
              color: color ?? LunaColours.accent,
              size: size,
            ),
          ],
        ),
      );
}
