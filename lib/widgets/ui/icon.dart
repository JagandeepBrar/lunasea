import 'package:flutter/material.dart';

class LSIcon extends StatelessWidget {
    final IconData icon;
    final Color color;

    LSIcon({
        @required this.icon,
        this.color = Colors.white,
    });

    @override
    Widget build(BuildContext context) {
        return Icon(
            icon,
            color: color,
        );
    }
}

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
