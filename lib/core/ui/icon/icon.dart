import 'package:flutter/material.dart';

class LSIcon extends StatelessWidget {
    final IconData icon;
    final Color color;
    final double size;

    LSIcon({
        @required this.icon,
        this.color = Colors.white,
        this.size,
    });

    @override
    Widget build(BuildContext context) => Icon(
        icon,
        color: color,
        size: size,
    );
}