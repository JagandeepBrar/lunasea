import 'package:flutter/material.dart';
import './icon.dart';

class LSIconButton extends StatelessWidget {
    final IconData icon;
    final Color color;
    final Function onPressed;

    LSIconButton({
        @required this.icon,
        this.color = Colors.white,
        this.onPressed,
    });

    @override
    Widget build(BuildContext context) {
        return IconButton(
            icon: LSIcon(
                icon: icon,
                color: color,
            ),
            onPressed: onPressed,
        );
    }
}
