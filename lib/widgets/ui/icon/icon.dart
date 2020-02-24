import 'package:flutter/material.dart';

class LSIcon extends StatelessWidget {
    final IconData icon;
    final Color color;

    LSIcon({
        @required this.icon,
        this.color = Colors.white,
    });

    @override
    Widget build(BuildContext context) => Icon(
        icon,
        color: color,
    );
}