import 'package:flutter/material.dart';
import 'package:lunasea/widgets/ui/colors.dart';

class LSDivider extends StatelessWidget {
    final double padding;
    final Color color;

    LSDivider({
        this.padding = 14.0,
        this.color,
    });

    @override
    Widget build(BuildContext context) {
        return Divider(
                color: color == null
                    ? LSColors.accent
                    : color,
                indent: padding,
                endIndent: padding,
        );
    }
}