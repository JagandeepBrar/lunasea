import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LSLoader extends StatelessWidget {
    final double size;
    final Color color;

    LSLoader({
        Key key,
        this.size = 20.0,
        this.color = Colors.white70,
    }): super(key: key);

    @override
    Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
            SpinKitThreeBounce(
                color: color,
                size: size,
            ),
        ],
    );
}
